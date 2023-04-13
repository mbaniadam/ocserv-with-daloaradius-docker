output "output_p" {
  value = "every thing is ok!"

}
output "public_ip" {
  value = aws_instance.ocserv.public_ip
  
}