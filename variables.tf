variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-2"
}

variable "azure_region" {
  type        = string
  description = "Region"
  default     = "eastus2"
}

variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "Azure Tenant ID"
}
