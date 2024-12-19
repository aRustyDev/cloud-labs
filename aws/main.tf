resource "random_uuid" "lab_tag" {} # random_uuid.test.result

module "lab" {
  source = "./privesc"

  target_lab = "via_assumeRole"
  time = {
    now = timestamp()
    end = timeadd(timestamp(), var.lab_duration)
  }

  tags = {
    lab_id = random_uuid.lab_tag.result
  }
}