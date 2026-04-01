output "length_result" {
  value = length([var.input_string, "b", "c"])
}

output "length_result2" {
  value = length({
    "x" = "y"
    "y" = "z"
  })
}

