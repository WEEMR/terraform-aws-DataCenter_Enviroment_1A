// Spoke 1 Apache Interface

resource "aws_network_interface" "Spoke1_Ubuntu_WebServer_eth0" {
  provider    = aws.virginia
  description = "${var.username}_Terraform_Spoke_1_Apache_eth0"
  subnet_id   = var.spoke_1_private_subnet_id
  private_ips = var.spoke_1_Ubuntu_LAN_IP
  security_groups = [var.Private_SG]

  tags = {
    Name = "${var.username}_TF_Spoke_1_Ubuntu_WebServer_Eth0"
  }
}

resource "time_sleep" "wait_6mins_30seconds" {
  depends_on      = [aws_instance.Spoke_1]
  create_duration = "400s"
}


resource "aws_instance" "Spoke_1_Apache" {
  provider          = aws.virginia
  depends_on        = [time_sleep.wait_6mins_30seconds]
  ami               = lookup(var.Ubuntu_WebServer_AMI, var.virginia_region)
  instance_type     = var.Ubuntu_VM_Size
  availability_zone = data.aws_availability_zones.AZs.names[0]
  key_name          = var.keyname

  root_block_device {
    volume_type = "standard"
    volume_size = "8"
  }

  network_interface {
    network_interface_id = aws_network_interface.Spoke1_Ubuntu_WebServer_eth0.id
    device_index         = 0
  }

  user_data = <<-EOF
  #!/bin/bash
  sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
  systemctl restart sshd
  service sshd restart
  #
  #TO DO: replace bob with your desired username
  #
  useradd ${var.username}
  sudo usermod -aG sudo ${var.username}
  sudo mkdir /home/${var.username}
  sudo usermod --shell /bin/bash --home /home/${var.username} ${var.username}
  sudo chown -R ${var.username}:${var.username} /home/${var.username}
  cp /etc/skel/.* /home/${var.username}/
  #
  #TO DO: replace fortinet123! with your desired password and admin with your username
  #
  yes ${var.Password} | sudo passwd ${var.username}
  #
  #      Install Apache  
  #
  sudo apt update -y
  sudo apt install -y apache2
  #
  #      Start Apache Service
  #
  sudo systemctl start apache2
  sudo systemctl enable apache2
  #
  #      Give User permissions to modify the /var/www folder 
  #
  sudo chown -R $\${var.username}:$\${var.username} /var/www
  #
  #      Create a simple webpage to be displayed by the Apache Server
  #
  echo "<html><style>body { font-size: 15px;}</style><body><h1>Hello, Everyone &#128075</h1><h2>This is our Spoke 1 Apache Server created via Terraform &#128079 &#128170; </h2></body></html>" > /var/www/html/index.html
  #
  #      Install Ubuntu Desktop (GNOME)  
  #
  sudo apt install -y gnome-session gnome-terminal
  #sudo apt-get install -y lxde
  #
  #     Install Firefox
  #
  sudo apt install -y firefox
  #
  #     Enable RDP 
  #
  sudo apt install -y xrdp
  sudo adduser xrdp ssl-cert
  #
  #    Restart the RDP service to enable it
  #
  sudo apt-get install -y elinks
  sudo systemctl restart xrdp
  sudo reboot
  
  EOF

  tags = {
    Name = "${var.username}_TF_Spoke1_Ubuntu_Apache_Server"
  }
}
