module "LOADBALANCER_VPC1" {
    source = "../../Modules/Compute-Modules/Default-Modules/Loadbalancer-Modules"
    
###############################
## Load Balancer ##
###############################

  create_load_balancer = false

  load_balancer_name = "test"
  use_name_prefix = false
  load_balancer_environment = "development"

  load_balancer_type = "gateway"
  internal_load_balancer = false
  enable_deletion_protection = false

## Application Load Balancer ##
  application = {
    application = {
      existing_subnets = []
      new_subnet_keys = []
      existing_security_groups = []
      new_security_group_keys = []
      ip_address_type = "ipv4"
      customer_owned_ipv4_pool = ""
      enable_http2 = false
      drop_invalid_header_fields = false
      idle_timeout = 75
    }
  }
  ## New Security Groups ##
    create_new_security_groups = false
    new_security_groups = {

      security_group_1 = {
        name        = "security_group_1"
        description = "This is a new security group" 
        vpc_id      = "vpcID" 

        ingress_rules = { 
          rule_1 = {
            description      = "all" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "-1" 
            cidr_blocks      = ["0.0.0.0/0"] 
            ipv6_cidr_blocks = []   
            self = false  
            }
          }

        egress_rules = {  
          rule_1 = {
            description      = "all" 
            from_port        = 0 
            to_port          = 0 
            protocol         = "-1" 
            cidr_blocks      = ["0.0.0.0/0"] 
            ipv6_cidr_blocks = []   
            self = false 
            }
          }

          tags = {
              "key" = "value" # Tags to associate with security group
            }
          }
        }

## Network Load Balancer ##
  network = {
    network = {
      existing_subnets = [] # Updateing forces new resource
      new_subnet_keys = [] # Updateing forces new resource
      customer_owned_ipv4_pool = ""
      ip_address_type = "ipv4"
      enable_cross_zone_load_balancing = false
    }
  }
## Gateway Load Balancer ##
  gateway = {
    gateway = {
      existing_subnets = ["asd","abc"] 
      new_subnet_keys = []
      customer_owned_ipv4_pool = ""
      ip_address_type = "ipv4"
    }
  }

## Create New Subnets ##
  create_new_subnets = false
  new_subnets = {

    subnet_1 = {
      subnet_name = "public_subnet_1"
      vpc_id = "sdsf"
      cidr_block = "192.168.1.0/24"
      availability_zone = "us-east-1a"
      customer_owned_ipv4_pool = "" 
      assign_ipv6_address_on_creation = false
      ipv6_cidr_block = ""
      map_customer_owned_ip_on_launch = false
      map_public_ip_on_launch = false
      outpost_arn = ""

      route_table_id_association = "Public_Route_Table_1"

      tags = {
          "Public_Subnet" = "Public_Subnet_1",
      }
    }

  }

## Subnet Mapping ##
  create_subnet_mapping = false
  subnet_mapping = {
      mapping_1 = {
        subnet_id = ""
        new_subnet_key = ""
        allocation_id = ""
        private_ipv4_address = ""
        ipv6_address = "ipv4"
      }
    }

## Access Logs ##
  create_s3_access_logs = false
  s3_access_logs = {
    values = {
      bucket = ""
      prefix = ""
      enable = false
    }
  }

## Tags ##
  load_balancer_tags = {
    "key" = "value"
  }

##########################################
## Application Load Balancer: Listeners ##
##########################################

create_listeners = false
listeners = {

  listener_1 = {

    ## Listener Settings ##
      port = 443
      protocol = "HTTPS"

    ## Listener SSL Certificates ##
      use_ssl_certificate = true
        ssl_certificates = {
          default_certificate = {
            default_ssl_policy = "ELBSecurityPolicy-2016-08"
            default_certificate_arn = ""
          }
        }
      use_additional_ssl_certificates = true
        additional_certificates = {
          cert_1 = {
            module_key = "1" # Must be unique
            listener_key = "listener_1"
            certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-123456789012"
          }
          cert_2 = {
            module_key = "2" # Must be unique
            listener_key = "listener_1"
            certificate_arn = "arn:aws:acm:us-east-1:123456789012:certificate/12345678-1234-1234-1234-1289012"
          }
        }

    ## Listener Default Actions ##
      default_actions = {
        action_1 = {
          type = "forward"
          values = {
            target_group_arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/131"
            target_groups = {
              target_group_1 = {
                arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/111"
                weight = 50
              }
              target_group_2 = {
                arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/112"
                weight = 50
              }
            } 
            stickiness = {
              enabled = true
              duration = 888
            }
          }
        }  
        action_2 = {
          type = "redirect"
          values = {
            status_code = "HTTP_302"
            host = "sdfgsdfg"
            path = "/"
            port = 80
            protocol = "HTTP"
            query = "#{query}"
          }
        }
        action_3 = {
          type = "fixed-response"
          values = {
            content_type = "text/html"
            message_body = "Now we are moving"
            status_code = "245"
          }
        }
        action_4 = {
          type = "authenticate-cognito"
          values = {
            user_pool_arn       = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/112"
            user_pool_client_id = "asdfasdf"
            user_pool_domain    = "yuh.com"
          }
        }
        action_5 = {
          type = "authenticate-oidc"
          values = {
            authorization_endpoint = "sdf"
            client_id              = "asdad"
            client_secret          = "aaaaaaaa"
            issuer                 = "yuh"
            token_endpoint         = "huh"
            user_info_endpoint     = "yuhhuh" 
          }
        }
      }
    }

}

###############################################
## Application Load Balancer: Listener Rules ##
###############################################

create_listener_rules = false
listener_rules = {

  rule_1 = {
    listener_map_key_name = "listener_1"
    priority = 100

  ## Listener Actions ##
    actions = {

      action_1 = {
        type = "forward"
        values = {
          target_group_arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/131"
          target_groups = {
            target_group_1 = {
              arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/111"
              weight = 50
            }
            target_group_2 = {
              arn = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/112"
              weight = 50
            }
          } 
          stickiness = {
            enabled = true
            duration = 888
          }
        }
      }

      action_2 = {
        type = "redirect"
        values = {
          status_code = "HTTP_302"
          host = "sdfgsdfg"
          path = "/"
          port = 80
          protocol = "HTTP"
          query = "#{query}"
        }
      }

      action_3 = {
        type = "fixed-response"
        values = {
          content_type = "text/html"
          message_body = "Now we are moving"
          status_code = "245"
        }
      }

      action_4 = {
        type = "authenticate-cognito"
        values = {
          user_pool_arn       = "arn:aws:elasticloadbalancing:us-west-2:123456789012:targetgroup/112"
          user_pool_client_id = "asdfasdf"
          user_pool_domain    = "yuh.com"
        }
      }

      action_5 = {
        type = "authenticate-oidc"
        values = {
          authorization_endpoint = "sdf"
          client_id              = "asdad"
          client_secret          = "aaaaaaaa"
          issuer                 = "yuh"
          token_endpoint         = "huh"
          user_info_endpoint     = "yuhhuh" 
        }
      }

  }

  ## Listener Conditions ##
    conditions = {

      host_header = {
        host_header_1 = {
          values = ["sdfghsfghd.*.kkjhgk"]
        }
      }

      http_header = {
        header_1 = {
          http_header_name = "fad333g"
          values = ["asdf"]
        }
        header_2 = {
          http_header_name = "ffffff"
          values = ["adf"]
        }
      }

      query_string = {
        string_1 = {
          key = "4"
          value = "asdfasdf"
        }
        string_2 = {
          key = "231"
          value = "asgdfgvvvvasdf"
        }
      }

      http_request_method = {
        method_1 ={
          values = ["aaaa", "bbbb"]
        }
      }

      path_pattern = {
        pattern_1 = {
          values = ["asdfasdfasdfasdf"]
        }
      }

      source_ip = {
        ip_1 = {
          values = ["192.168.0.4/32"]
        }
      }

    }
  }   

}




}