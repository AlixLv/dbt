# Tutoriel dbt avec DuckDB

Ce dépôt accompagne un tutoriel de prise en main de [dbt](https://www.getdbt.com/) (data build tool). L'entrepôt de données est [DuckDB](https://duckdb.org/) via l'adaptateur [`dbt-duckdb`](https://github.com/duckdb/dbt-duckdb) : tout fonctionne en local, sans compte, sans carte bancaire et sans quota.

## Objectifs

1. Configurer la connexion de dbt à l'entrepôt de données (fichier `profiles.yml`).
2. Créer des modèles types et les exécuter.
3. Ajouter des tests de qualité des données et des tests unitaires.
4. Produire la documentation du projet.

## Prérequis

- Python 3.11 ou 3.12 (recommandé : `dbt-core` 1.8 est testé jusqu'à Python 3.12)
- `git`
- Un terminal (macOS, Linux ou WSL sous Windows)

## Installation

```bash
# 1. Cloner le dépôt
git clone <url-du-depot>
cd tuto_dbt

# 2. Créer et activer un environnement virtuel
python -m venv .venv
source .venv/bin/activate        # Windows : .venv\Scripts\activate

# 3. Installer les dépendances
pip install -r requirements.txt

# 4. Vérifier l'installation
dbt --version
```

La commande doit afficher `dbt-core` 1.8.6 et le plugin `duckdb` 1.8.4.

## Configuration

Le fichier `profiles.yml` est à la racine du projet. Il indique à dbt où écrire les données :

```yaml
tuto_dbt:
  target: dev
  outputs:
    dev:
      type: duckdb
      path: dev.duckdb
      threads: 1
```

- `path: dev.duckdb` : les tables et vues sont enregistrées dans ce fichier, donc **conservées d'une session à l'autre**. Avec `path: ":memory:"`, tout disparaîtrait à la fin de chaque commande.
- Le nom du profil (`tuto_dbt`) doit correspondre au champ `profile:` de `dbt_project.yml`.
- Ce profil ne contient aucun secret : il peut être versionné.

Lancez toujours les commandes dbt **depuis la racine du projet** : dbt y trouve alors `profiles.yml` automatiquement. Sinon, ajoutez `--profiles-dir .` à chaque commande, ou définissez la variable d'environnement (à refaire à chaque nouvelle session de terminal) :

```bash
export DBT_PROFILES_DIR=.
```

Vérifiez la configuration :

```bash
dbt debug
```

Le message `All checks passed!` confirme que tout est en ordre.

## Commandes principales

| Commande | Rôle |
|----------|------|
| `dbt debug` | Vérifie la configuration et la connexion |
| `dbt compile` | Génère le SQL compilé dans `target/compiled/`, sans l'exécuter |
| `dbt run` | Crée les tables et vues dans `dev.duckdb` |
| `dbt test` | Exécute les tests de qualité des données et les tests unitaires |
| `dbt build` | Enchaîne `run` et `test` dans l'ordre des dépendances |
| `dbt docs generate` | Génère la documentation |
| `dbt docs serve` | Ouvre la documentation dans le navigateur |

## Structure du projet

```text
tuto_dbt/
├── analyses/          # Requêtes d'analyse non matérialisées
├── macros/            # Macros Jinja réutilisables
├── models/            # Modèles SQL et fichiers YAML (tests, documentation)
├── seeds/             # Données CSV chargées dans l'entrepôt
├── snapshots/         # Historisation des données
├── tests/             # Tests personnalisés
├── dbt_project.yml    # Configuration du projet
├── profiles.yml       # Connexion à DuckDB
└── requirements.txt   # Dépendances Python (versions épinglées)
```

## Points d'attention

- **Verrou DuckDB** : un seul processus peut écrire dans `dev.duckdb` à la fois. Si le fichier est ouvert dans un autre outil (CLI DuckDB, notebook, client SQL) pendant un `dbt run`, une erreur de verrou apparaît. Fermez l'autre connexion, puis relancez la commande.
- **Fichiers non versionnés** : `dev.duckdb`, `target/`, `logs/` et l'environnement virtuel sont ignorés par Git. Ils sont régénérés par `dbt build`.
- **Tests unitaires** : ils nécessitent `dbt-core` 1.8 ou supérieur.

## Pour aller plus loin

- Se connecter à un entrepôt cloud : [MotherDuck](https://motherduck.com/) (même adaptateur `dbt-duckdb`, avec un chemin `md:nom_base` et un jeton d'accès) ou [BigQuery](https://docs.getdbt.com/docs/core/connect-data-platform/bigquery-setup) avec un compte de service.
- [Documentation de dbt](https://docs.getdbt.com/)
- [Documentation de dbt-duckdb](https://github.com/duckdb/dbt-duckdb)



### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
