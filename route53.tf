# resource "aws_route53_zone" "cognoma" {
#   name = "cognoma.org"
# }

variable "cognoma-domain" {
  default = "cognoma.org"
}

data "aws_route53_zone" "cognoma" {
  zone_id = "Z2GDAYII3P3OEX"
}

resource "aws_ses_domain_identity" "cognoma" {
  domain = "${var.cognoma-domain}"
}

resource "aws_route53_record" "cognoma-api" {
  zone_id = "${data.aws_route53_zone.cognoma.zone_id}"
  name = "api.${var.cognoma-domain}"
  type = "A"

  alias {
    name = "${aws_elb.cognoma-nginx.dns_name}"
    zone_id = "${aws_elb.cognoma-nginx.zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "cognoma-dot-org" {
   name = "${var.cognoma-domain}"
   zone_id = "${data.aws_route53_zone.cognoma.zone_id}"
   type = "A"
   alias {
     name = "${aws_s3_bucket.cognoma-static.website_domain}"
     zone_id = "${aws_s3_bucket.cognoma-static.hosted_zone_id}"
     evaluate_target_health = true
   }

  depends_on = ["aws_s3_bucket.cognoma-static"]
}

resource "aws_route53_record" "cognoma-ses-verification-record" {
  zone_id = "${data.aws_route53_zone.cognoma.zone_id}"
  name = "${var.cognoma-domain}"
  type = "TXT"
  ttl = "5"
  records = ["${aws_ses_domain_identity.cognoma.verification_token}"]
}
