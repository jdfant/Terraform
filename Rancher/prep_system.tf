resource "null_resource" "remote-exec" {
  connection {
    host        = var.node_ip[0]
    user        = var.users[1]
    private_key = file(var.private_ssh_key)
  }

  provisioner "file" {
    source      = "./scripts/iptables.sh"
    destination = "/tmp/iptables.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/iptables.sh",
      "/tmp/iptables.sh",
    ]
  }
}
