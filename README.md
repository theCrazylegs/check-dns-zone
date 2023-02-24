# DNS Configuration Verification

This script checks if a DNS zone is correctly set up with respect to its known value.

If you don't have the chance to have an API to manage your zone files and you have a really huge number of domains and zones to enter manually, this small script without any pretension can help you check for any omission or error.

## Usage

To use this script, you must provide the following arguments:

```./dns_check.sh <zone (Subdomain or Domain)> <zone type (A, TXT or MX)> <expected value> [value type example google spf]```

The different types of supported zones are A and TXT. For TXT zones, you can also specify a value type to check for the presence of multiple TXT records on the domain.

## Examples

Here are some examples of how to use this script:

```BASH
./dns_check.sh yourdomaine.com A 192.168.0.1
./dns_check.sh yourdomaine.com TXT "google-site-verification=*********************************" "google"
./dns_check.sh yourdomaine.com TXT "v=spf1 include:spf1.tondomaine.com ~all" "spf1"
./dns_check.sh yourdomaine.com MX mx.yourdomaine.com
./dns_check.sh mx.yourdomaine.com A 192.168.0.2
```

## License

This script is distributed under the GNU General Public License. See `LICENSE.md` for more information.




----------------------------------------------------------------------------------------------------------------------------




# Vérification de la configuration DNS

Ce script permet de vérifier si une zone DNS est correctement renseignée par rapport à sa valeur connue.

Si vous n'avez pas la chance d'avoir accès à une API pour gérer automatiquement vos fichiers de zone DNS et que vous devez entrer manuellement de nombreuses zones pour de nombreux domaines, ce petit script sans prétention peut vous aider à vérifier s'il y a des erreurs ou des oublis.

## Utilisation

Pour utiliser ce script, vous devez fournir les arguments suivants :

```./dns_check.sh <zone (Sous Domaine ou Domaine)> <type de zone (A, TXT ou MX)> <valeur attendue> [type valeur exemple google spf]```

Les différents types de zone pris en charge sont A, TXT et MX. Pour les zones TXT, vous pouvez également spécifier un type de valeur pour vérifier la présence de plusieurs enregistrements TXT sur le domaine.

## Exemples

Voici quelques exemples d'utilisation de ce script :

```BASH
./dns_check.sh tondomaine.com A 192.168.0.1
./dns_check.sh tondomaine.com TXT "google-site-verification=*********************************" "google"
./dns_check.sh tondomaine.com TXT "v=spf1 include:spf1.tondomaine.com ~all" "spf1"
./dns_check.sh tondomaine.com MX mx.tondomaine.com
./dns_check.sh mx.tondomaine.com A 192.168.0.2
```

## Licence

Ce script est distribué sous la licence GNU générale. Voir `LICENSE.md` pour plus d'informations.
