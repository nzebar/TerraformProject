module "SECURITY_GROUPS_VPC1" {
    source = "../../Modules/Compute-Modules/Default-Modules/Security-Groups-Modules"

public_security_groups = {

    pub_security_group_1 = {
        name        = "Public_Security_Group"
        description = "Allow TLS inbound traffic"
        vpc_id      = "id-dgbfrb2222"

        ingress_rules = {
            rule_1 = {
                description      = "TLS from VPC"
                from_port        = 0
                to_port          = 0
                protocol         = "-1"
                cidr_blocks      = ["0.0.0.0/0"]
              # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]    
            }
        }

        egress_rules = {
            rule_1 = {
                description      = "TLS from VPC"
                from_port        = 0
                to_port          = 0
                protocol         = "-1"
                cidr_blocks      = ["0.0.0.0/0"]
              # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]    
            }
        }

    tags = {
        "key" = "value"
    }

    }

}

private_security_groups = {
    priv_security_group_1 = {
        name        = "Private_Security_Group"
        description = "Allow TLS inbound traffic"
        vpc_id      = "id-sdfgd2222"

        ingress_rules = {
            rule_1 = {
                description      = "TLS from VPC"
                from_port        = 0
                to_port          = 0
                protocol         = "-1"
                cidr_blocks      = ["0.0.0.0/0"]
              # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]    
            }
        }

        egress_rules = {
            rule_1 = {
                description      = "TLS from VPC"
                from_port        = 0
                to_port          = 0
                protocol         = "-1"
                cidr_blocks      = ["0.0.0.0/0"]
              # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]    
            }
        }

    tags = {
        "key" = "value"
    }

    }
}

database_security_groups = {
    db_security_group_1 = {
        name        = "Database Security Group"
        description = "Allow TLS inbound traffic"
        vpc_id      = "id-gdrtg33456"

        ingress_rules = {
            rule_1 = {
                description      = "TLS from VPC"
                from_port        = 0
                to_port          = 0
                protocol         = "-1"
                cidr_blocks      = ["0.0.0.0/0"]
              # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]    
            }
        }

        egress_rules = {
            rule_1 = {
                description      = "TLS from VPC"
                from_port        = 0
                to_port          = 0
                protocol         = "-1"
                cidr_blocks      = ["0.0.0.0/0"]
              # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]    
            }
        }

    tags = {
        "key" = "value"
    }

    }
}
    
}