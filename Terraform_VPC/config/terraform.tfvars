
region = "us-east-1"

access_key = ""
secret_key = ""

vpc_config = {


    vpc01 = {

      vpc_cidr_block = "198.168.0.0/16"

      tags = {
        "Name" = "TCS"
      }  
    }
}

subnet_config = {
    
    vpc_name = "vpc01"
    
    "pub_us_east_1a" = {

    cidr_block = "198.168.0.0/18"

    availability_zone = "us-east-1a"

    tags = {

    "Name" = "pub_us_east_1a"
    }

    }

    "pub_us_east_1b" = {

    vpc_name = "vpc01"

    cidr_block = "198.168.64.0/18"

    availability_zone = "us-east-1a"

    tags = {

    "Name" = "pub_us_east_1b"
    }

    }
    
    "pvt_us_east_1a" = {

    vpc_name = "vpc01"

    cidr_block = "198.168.128.0/18"

    availability_zone = "us-east-1a"

    tags = {

    "Name" = "pvt_us_east_1a"
    }

    }

    "pvt_us_east_1b" = {

    vpc_name = "vpc01"

    cidr_block = "198.168.192.0/18"

    availability_zone = "us-east-1b"

    tags = {

    "Name" = "pvt_us_east_1b"
    }

    }
}

igw_config = {

  igw01 = {

    vpc_name = "vpc01"

    tags = {
      "Name" = "my_igw"
    }

  }
}

elasticIP_config = {

  eip01 = {

    tags = {
      "Name" = "nat01"
    }
  }

    eip02 = {

    tags = {
      "Name" = "nat02"
    }
  }

}

natGW_config = {

  natgw01 = {

    elastic_name = "eip01"

    subnet_name = "pub_us_east_1a"

    tags = {
      "Name" = "nat01"

    }

  }

    natgw02 = {

    elastic_name = "eip02"

    subnet_name = "pub_us_east_1b"

    tags = {
       "Name" = "nat02"

    }

  }

}


rt_config = {

  routetable01 = {
    private = 0
    vpc_name = "vpc01"

    gateway_name = "igw01"

    tags = {

      "Name" = "Public_rt"

    }
  }
    
  routetable02 = {
    private = 1
    vpc_name = "vpc01"

    gateway_name = "natgw01"

    tags = {
       "Name" = "Private_rt"

    }
  }

  routetable03 = {
    private = 1
    vpc_name = "vpc01"

    gateway_name = "natgw02"

    tags = {
       "Name" = "Private_rt"

    }
  }
}

rt_association_config = {

RT_Assoc_01 = {
  subnet_name = "pub_us_east_1a"

  route_table_name = "routetable01"

}
RT_Assoc_02 = {
  subnet_name = "pub_us_east_1b"

  route_table_name = "routetable01"
}
RT_Assoc_03 = {
  subnet_name = "pvt_us_east_1a"

  route_table_name = "routetable02"
}
RT_Assoc_04 = {
  subnet_name = "pvt_us_east_1b"

  route_table_name = "routetable03"
  
}

}