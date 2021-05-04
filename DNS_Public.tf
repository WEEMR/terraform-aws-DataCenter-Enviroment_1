data "aws_route53_zone" "Public_Hosted_Zone" {
  name = var.Public_Hosted_Zone
}

resource "aws_route53_zone" "Public_SubHosted_Zone" {
  name = var.SubHosted_Zone
}

resource "aws_route53_record" "activate_zone" {
  zone_id = data.aws_route53_zone.Public_Hosted_Zone.zone_id
  name    = aws_route53_zone.SubHosted_Zone.name
  type    = "NS"
  ttl     = "10"
  records = aws_route53_zone.Public_SubHosted_Zone.name_servers
}

resource "aws_route53_record" "FMG_Public" {
  zone_id = aws_route53_zone.Public_SubHosted_Zone.zone_id
  name    = "FMG.${aws_route53_zone.Public_SubHosted_Zone.name}"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.FMG_WAN_IP.public_ip]
}


resource "aws_route53_record" "FGT_Public" {
  zone_id = aws_route53_zone.Public_SubHosted_Zone.zone_id
  name    = "FGT.${aws_route53_zone.Public_SubHosted_Zone.name}"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.FGT_EIP.public_ip]
}

resource "time_sleep" "wait_15_seconds" {
  depends_on = [aws_route53_record.FGT_Public]

  create_duration = "15s"
}

resource "aws_route53_record" "Linux_Public" {
  depends_on = [time_sleep.wait_15_seconds]
  zone_id    = aws_route53_zone.Public_SubHosted_Zone.zone_id
  name       = "linux.${aws_route53_zone.Public_SubHosted_Zone.name}"
  type       = "A"

  alias {
    name                   = "fgt.${aws_route53_zone.Public_SubHosted_Zone.name}"
    zone_id                = aws_route53_zone.Public_SubHosted_Zone.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "WebServer_Public" {
  depends_on = [time_sleep.wait_15_seconds]
  zone_id    = aws_route53_zone.Public_SubHosted_Zone.zone_id
  name       = "WebServer.${aws_route53_zone.Public_SubHosted_Zone.name}"
  type       = "A"

  alias {
    name                   = "fgt.${aws_route53_zone.Public_SubHosted_Zone.name}"
    zone_id                = aws_route53_zone.Public_SubHosted_Zone.zone_id
    evaluate_target_health = true
  }
}
