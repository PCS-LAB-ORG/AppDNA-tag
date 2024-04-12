from __future__ import annotations

from typing import Any

from checkov.terraform.checks.resource.base_resource_check import BaseResourceCheck
from checkov.common.models.enums import CheckResult, CheckCategories


class AppDNATAG(BaseResourceCheck):
    def __init__(self) -> None:
        name = "Ensure ressources have an Application tag"
        id = "CKV_AWS_888888"
        supported_resources = ("aws_s3_bucket","aws_db_instance","aws_instance")
        # CheckCategories are defined in models/enums.py
        categories = (CheckCategories.BACKUP_AND_RECOVERY,)
        guideline = "Follow the link to get more info https://docs.prismacloud.io/en/enterprise-edition/policy-reference"
        super().__init__(name=name, id=id, categories=categories, supported_resources=supported_resources, guideline=guideline)

    def scan_resource_conf(self, conf: dict[str, list[Any]]) -> CheckResult:
        """
            Look for Application tag:
            https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
        :param conf: aws_s3_bucket aws_db_instance aws_instance configuration
        :return: <CheckResult>
        """
        tags = conf.get("tags")
        if tags and isinstance(tags, list):
            tags = tags[0]
            if "Application" in tags:
                    return CheckResult.PASSED
        return CheckResult.FAILED


check = AppDNATAG()