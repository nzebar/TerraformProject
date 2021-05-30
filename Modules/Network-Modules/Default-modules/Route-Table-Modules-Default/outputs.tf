#################################
## Default route table Outputs ##
#################################

output "aws_default_route_table_default" {
    value = aws_default_route_table.default
}

#################################
## Public route table Outputs ##
#################################

output "Public_Route_Table_1" {
    value = aws_route_table.route_tables["Public_Route_Table_1"]
}

output "Public_Route_Table_2" {
    value = aws_route_table.route_tables["Public_Route_Table_2"]
}

#################################
## Private route table Outputs ##
#################################

output "Private_Route_Table_1" {
    value = aws_route_table.route_tables["Private_Route_Table_1"]
}

output "Private_Route_Table_2" {
    value = aws_route_table.route_tables["Private_Route_Table_2"]
}

##################################
## Database route table Outputs ##
##################################

output "Database_Route_Table_1" {
    value = aws_route_table.route_tables["Database_Route_Table_1"]
}

output "Database_Route_Table_2" {
    value = aws_route_table.route_tables["Database_Route_Table_2"]
}

output "Database_Route_Table_3" {
    value = aws_route_table.route_tables["Database_Route_Table_3"]
}

