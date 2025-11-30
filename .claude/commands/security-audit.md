# Security Audit

Perform a comprehensive security audit of the codebase or specified files.

## Instructions

Analyze the code for security vulnerabilities following OWASP guidelines and security best practices.

### 1. Injection Vulnerabilities
- SQL Injection
- NoSQL Injection
- Command Injection
- LDAP Injection
- XPath Injection
- Template Injection

### 2. Authentication & Session Management
- Weak password policies
- Insecure session handling
- Missing authentication
- Broken authentication flows
- JWT vulnerabilities
- OAuth/OIDC misconfigurations

### 3. Authorization Issues
- Broken access control
- Privilege escalation paths
- Insecure direct object references (IDOR)
- Missing function-level access control
- CORS misconfigurations

### 4. Data Exposure
- Sensitive data in logs
- Hardcoded secrets/credentials
- Sensitive data in URLs
- Missing encryption for sensitive data
- Insecure data storage
- PII exposure risks

### 5. Cross-Site Scripting (XSS)
- Reflected XSS
- Stored XSS
- DOM-based XSS
- Missing output encoding
- Unsafe innerHTML usage

### 6. Security Misconfigurations
- Debug mode in production
- Default credentials
- Unnecessary features enabled
- Missing security headers
- Verbose error messages
- Directory listing enabled

### 7. Dependency Vulnerabilities
- Known CVEs in dependencies
- Outdated packages
- Untrusted sources
- Typosquatting risks

### 8. Cryptographic Issues
- Weak algorithms
- Insufficient key lengths
- Hardcoded keys/IVs
- Insecure random number generation
- Missing integrity checks

### 9. API Security
- Rate limiting absence
- Missing input validation
- Mass assignment vulnerabilities
- Excessive data exposure
- Lack of resource limits

### 10. File Handling
- Path traversal vulnerabilities
- Unrestricted file uploads
- Insecure file permissions
- Temporary file handling

## Output Format

```
## Security Audit Report

**Scope:** [files/directories audited]
**Date:** [current date]
**Risk Level:** [Critical/High/Medium/Low]

### Critical Vulnerabilities 🔴

🔴 **Critical**: [vulnerability type]
   **Location**: [file:line]
   **Description**: [detailed description]
   **OWASP Category**: [e.g., A01:2021 Broken Access Control]
   **Impact**: [potential impact if exploited]
   **Remediation**: [specific fix instructions]
   **References**: [CVE/CWE if applicable]

### High Risk Issues 🟠

🟠 **High**: [issue]
   **Location**: [file:line]
   **Description**: [description]
   **Impact**: [impact]
   **Remediation**: [fix]

### Medium Risk Issues 🟡

🟡 **Warning**: [issue]
   **Location**: [file:line]
   **Description**: [description]
   **Remediation**: [fix]

### Low Risk / Informational 🔵

🔵 **Suggestion**: [issue]
   **Location**: [file:line]
   **Recommendation**: [recommendation]

### Security Best Practices Not Followed

- [ ] [practice 1]
- [ ] [practice 2]

### Recommendations Summary

1. **Immediate Actions** (fix within 24 hours)
   - [action 1]

2. **Short-term Actions** (fix within 1 week)
   - [action 1]

3. **Long-term Improvements**
   - [improvement 1]

### Vulnerability Statistics

| Severity | Count |
|----------|-------|
| Critical | X |
| High | X |
| Medium | X |
| Low | X |
```

## Usage

```
/security-audit [file or directory]
/security-audit  # Audits entire codebase
```

Audit $ARGUMENTS or entire codebase if no arguments provided.
