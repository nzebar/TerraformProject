{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "auditmanager:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "securityhub:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "macie:*",
                "macie2:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "inspector:*"
            ],
            "Resource": "*"
        },     
        {
            "Effect": "Allow",
            "Action": [
                "guardduty:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "cloudhsm:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "waf:*",
                "waf-regional:*",
                "wafv2:*",
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "detective:*"
            ],
            "Resource": "*"
        }
    ]
}