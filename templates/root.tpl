[ default ]
ca                      = {{CA_NAME}}
domain                  = {{CA_DOMAIN}}
base_url                = https://$domain/ca       # CA base URL
aia_url                 = $base_url/$ca.crt        # CA certificate URL
crl_url                 = $base_url/$ca.crl        # CRL distribution point
name_opt                = multiline,-esc_msb,utf8  # Display UTF-8 characters

########################################
#
# CA certificate request
# Configuration for `openssl req ...`
#

[ req ]
default_bits            = 4096                  # RSA key size
default_days            = 1826                  # How long to certify for
encrypt_key             = yes                   # Protect private key
default_md              = sha256                # MD to use
utf8                    = yes                   # Input is UTF-8
string_mask             = utf8only              # Emit UTF-8 strings
prompt                  = no                    # Don't prompt for DN
distinguished_name      = req_dn                # DN section
req_extensions          = req_ext               # Desired extensions

[ req_dn ]
countryName             = "{{CA_CERT_C}}"
stateOrProvinceName     = "{{CA_CERT_ST}}"
localityName            = "{{CA_CERT_L}}"
organizationName        = "{{CA_CERT_O}}"
organizationalUnitName  = "{{CA_CERT_OU}}"
commonName              = "{{CA_CERT_CN}}"

[ req_ext ]
keyUsage                = critical,keyCertSign,cRLSign
basicConstraints        = critical,CA:true
subjectKeyIdentifier    = hash

########################################
#
# CA operational settings
# Configuration for `openssl ca ...`
#

[ ca ]
default_ca              = root_ca               # The default CA section

[ root_ca ]
cert_opt                = ca_default            # Certificate display options
certificate             = ca/ca.crt             # The CA cert
copy_extensions         = copy                  # Copy extensions from CSR
crl                     = crl/ca.crl            # CRL path
crl_extensions          = crl_ext               # CRL extensions
crlnumber               = ca/db/crl.srl         # CRL number file
database                = ca/db/certificate.db  # Index file
default_crl_days        = 30                    # How long before next CRL
default_days            = 1826                  # How long to certify for
default_md              = sha256                # MD to use
email_in_dn             = no                    # Add email to cert DN
name_opt                = ca_default            # Subject DN display options
new_certs_dir           = archive               # Certificate archive
policy                  = root_ca_pol           # Default naming policy
preserve                = no                    # Keep passed DN ordering
private_key             = ca/private/ca.key     # CA private key
serial                  = ca/db/crt.srl         # Serial number file
unique_subject          = no                    # Require unique subject
x509_extensions         = signing_ca_ext        # Default cert extensions

[ root_ca_pol ]
countryName             = match                 # Must match
stateOrProvinceName     = match                 # Must match
localityName            = optional              # Included if present
organizationName        = match                 # Must match
organizationalUnitName  = optional              # Included if present
commonName              = supplied              # Must be present

# Extensions for signing certs issued by this root CA
[ root_ca_ext ]
keyUsage                = critical,keyCertSign,cRLSign
basicConstraints        = critical,CA:true
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always

# Extensions for signing CAs issued by this root CA
[ signing_ca_ext ]
keyUsage                = critical,keyCertSign,cRLSign
basicConstraints        = critical,CA:true,pathlen:0
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always
authorityInfoAccess     = @issuer_info
crlDistributionPoints   = @crl_info

# Extensions for signing certs issued by this signing CA
[ server_ext ]
keyUsage                = critical,digitalSignature,keyEncipherment
basicConstraints        = critical,CA:false
extendedKeyUsage        = critical,serverAuth,clientAuth
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always
authorityInfoAccess     = @issuer_info
crlDistributionPoints   = @crl_info

[ client_ext ]
keyUsage                = critical,digitalSignature
basicConstraints        = critical,CA:false
extendedKeyUsage        = critical,clientAuth
subjectKeyIdentifier    = hash
authorityKeyIdentifier  = keyid:always
authorityInfoAccess     = @issuer_info
crlDistributionPoints   = @crl_info

[ crl_ext ]
authorityKeyIdentifier  = keyid:always
authorityInfoAccess     = @issuer_info

[ issuer_info ]
caIssuers;URI.0         = $aia_url

[ crl_info ]
URI.0                   = $crl_url
