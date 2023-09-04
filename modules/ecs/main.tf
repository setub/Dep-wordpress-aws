resource "aws_security_group" "service_security_group" {
  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # Only allowing traffic in from the load balancer security group
    security_groups = ["${var.lb-security-group}"]
  }

  egress {
    from_port   = 0             # Allowing any incoming port
    to_port     = 0             # Allowing any outgoing port
    protocol    = "-1"          # Allowing any outgoing protocol 
    cidr_blocks = ["0.0.0.0/0"] # Allowing traffic out to all IP addresses
  }
}

resource "aws_ecs_cluster" "wordpress_cluster" {
  name = var.ecs-cluster-name
}

resource "aws_ecs_task_definition" "wordpress_task" {
  family = "wordpress-app" # Naming our first task
  container_definitions = jsonencode([{
    name  = "wordpress-app"
    image = var.wordpress-image
    portMappings = [{
      hostPort      = 80
      containerPort = 80
      protocol      = "tcp"
    }]
    essential = true
    environment = [
      {
        name  = "WORDPRESS_DB_HOST"
        value = var.rds-url
      },
      {
        name  = "WORDPRESS_DB_USER"
        value = var.rds-username
      },
      {
        name  = "WORDPRESS_DB_PASSWORD"
        value = var.rds-password
      },
      {
        name  = "WORDPRESS_DB_NAME"
        value = var.rds-dbname
      }
    ]
    logConfiguration = {
      logDriver = "awslogs",
      options = {
        "awslogs-group"         = var.cloudwatch-log
        "awslogs-region"        = var.aws-region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])
  requires_compatibilities = ["FARGATE"] # Stating that we are using ECS Fargate
  network_mode             = "awsvpc"    # Using awsvpc as our network mode as this is required for Fargate  
  memory                   = 512         # Specifying the memory our container requires
  cpu                      = 256         # Specifying the CPU our container requires
  execution_role_arn       = var.ecs-task-execution-role-arn
}

resource "aws_ecs_service" "wordpress_service" {
  name            = "wordpress-service"                        # Naming our first service
  cluster         = aws_ecs_cluster.wordpress_cluster.id       # Referencing our created Cluster
  task_definition = aws_ecs_task_definition.wordpress_task.arn # Referencing the task our service will spin up
  launch_type     = "FARGATE"
  desired_count   = 3 # Setting the number of containers we want deployed to 3

  load_balancer {
    target_group_arn = var.ecs-target-group-arn # Referencing our target group
    container_name   = aws_ecs_task_definition.wordpress_task.family
    container_port   = 80 # Specifying the container port
  }

  network_configuration {
    subnets          = var.subnets
    assign_public_ip = true                                                                             # Providing our containers with public IPs
    security_groups  = ["${aws_security_group.service_security_group.id}", "${var.rds-security-group}"] # Setting the security group
  }
}