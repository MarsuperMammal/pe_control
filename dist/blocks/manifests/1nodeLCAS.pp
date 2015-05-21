class blocks::1nodeLCAS {
  ec2_launchconfiguration { "${stack}_arbiter":
    security_groups => $security_groups,
    key_name        => $key_name,
    region          => $region,
    instance_type   => $instance_type,
    image_id        => $image_id,
    vpc             => $vpc,
  }
  ec2_autoscalinggroup { "${stack}_1node":
    min_size             => 1,
    max_size             => 1,
    region               => $region,
    launch_configuration => "${stack}_arbiter",
    availability_zones   => $availability_zones,
    subnets              => $subnets,
  }
}
    
