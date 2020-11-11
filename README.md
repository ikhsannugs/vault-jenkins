1. Run instal-vault.sh
2. Login ke browser lalu buat baru clusternya, 5:3, download key rootnya.
3. install jenkins
4. install HashiCorp Vault Plugin di jenkins
5. Buat Policy di vault

path "kv/data/secret/jenkins/*" {
    capabilities = [ "read" ]
}

6. Buat auth method menggunakan username&password
7. masukkan policy tadi ke dalam auth method yang dibuat
8. Generate token auth method yang dibuat di command line
9. Test tokennnya menggunakan command line
10. Buat credential berdasarkan token tadi di jenkins
11. Buat jenkins filenya 

