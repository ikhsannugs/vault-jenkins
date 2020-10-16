1. install vault
2. Login ke browser lalu buat baru clusternya, 5:3, download key rootnya.
3. install jenkins
4. install HashiCorp Vault Plugin di jenkins
5. Buat Policy di vault

path "kv/data/secret/jenkins/*" {
    capabilities = [ "read" ]
}

6. Buat auth method menggunakan username&password
7. masukkan auth method tadi ke dalam policy
8. Generate token auth method yang dibuat di command line
9. Test 
