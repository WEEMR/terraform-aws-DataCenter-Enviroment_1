resource "aws_route53_zone" "PvtHostedZone" {
  name = var.SubHosted_Zone
  vpc {
    vpc_id = aws_vpc.SDWAN_VPC.id
  }
}

resource "aws_route53_record" "Private_FMG" {
  zone_id = aws_route53_zone.PvtHostedZone.zone_id
  name    = "FMG.${aws_route53_zone.PvtHostedZone.name}"
  type    = "A"
  ttl     = "10"
  records = [aws_network_interface.FMG_eth0.private_ip]
}


resource "aws_route53_record" "Private_FGT" {
  zone_id = aws_route53_zone.PvtHostedZone.zone_id
  name    = "FGT.${aws_route53_zone.PvtHostedZone.name}"
  type    = "A"
  ttl     = "10"
  records = [aws_network_interface.FGT_eth0.private_ip]
}

resource "aws_route53_record" "Private_Linux" {
  zone_id = aws_route53_zone.PvtHostedZone.zone_id
  name    = "Linux.${aws_route53_zone.PvtHostedZone.name}"
  type    = "A"
  ttl     = "10"
  records = [aws_network_interface.Ubuntu_WebServer_eth0.private_ip]
}


resource "aws_route53_record" "Private_WebServer" {
  zone_id = aws_route53_zone.PvtHostedZone.zone_id
  name    = "WebServer.${aws_route53_zone.PvtHostedZone.name}"
  type    = "A"

  alias {
    name                   = "Linux.${aws_route53_zone.PvtHostedZone.name}"
    zone_id                = aws_route53_zone.PvtHostedZone.zone_id
    evaluate_target_health = true
  }
}
