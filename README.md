# ansible-interactive-tutorial

Leçons interactives sur Ansible.

## Prérequis

Le seul prérequis est **docker** (version 1.9+, testé avec la version 1.12+), Linux :

```bash
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
```

Vous pouvez aussi passer par [http://play-with-docker.com](http://play-with-docker.com) (Cliquez sur "+ ADD NEW INSTANCE" et choisissez ce repo).

Docker Desktop est aussi disponible pour Windows [Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/) et pour Mac [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/).

## Comment lancer le tutoriel

```bash
./tutorial.sh
```

[![demo](https://asciinema.org/a/CPUhOGGlcLiXVlZKIuiuk5Q7f.png)](https://asciinema.org/a/CPUhOGGlcLiXVlZKIuiuk5Q7f?autoplay=1)

## Nettoyage

```bash
./tutorial.sh --remove
```

## Plus de détails

### Leçons

Ce projet est fondé sur [turkenh/ansible-interactive-tutorial](https://github.com/turkenh/ansible-interactive-tutorial) qui s'inspire largement du repo [leucos/ansible-tuto](https://github.com/leucos/ansible-tuto) :

```
1) Pour commencer
2) Inventaire de base
3) Premiers modules et facts
4) Groupes et variables
5) Playbooks
6) Playbooks, pousser des fichiers sur les noeuds
7) Playbooks et les erreurs
8) Playbooks et les conditions
9) Module Git
10) Etendre le playbook à plusieurs hôtes
11) Templates - Modèles
12) Encore des variables
13) Migration vers les rôles
14) Utiliser des rôles Ansible Galaxy - Installer un serveur Jenkins
15) Jeux libres
16) Exercices du support https://iac.goffinet.org
```

Vous pouvez exécuter chaque leçon individuellement mais il est **fortement conseillé de suivre l'ordre** car la plupart d'entre elles sont construites sur la précédente !

J'ai ajouté une leçon 16) Exercices du support https://iac.goffinet.org qui prend en charge les exemples de ce support de formation mais sans interactivité.

### Conteneurs

`tutorial.sh` démarre quatre conteneurs docker en coulisses. Un pour exécuter le tutoriel lui-même et trois en tant que nœuds qui se comportent exactement comme des machines (virtuelles ou physiques) dans le tutoriel.

**ansible.tutorial** est un conteneur de tutoriel Alpine Linux dans lequel ansible et [nutsh](https://github.com/turkenh/nutsh) (un canevas pour créer des tutoriels interactifs en ligne de commande) sont disponibles. On le trouve sur [https://hub.docker.com/repository/docker/goffinet/ansible-tutorial](https://hub.docker.com/repository/docker/goffinet/ansible-tutorial) avec le [Dockerfile](https://github.com/goffinet/ansible-interactive-tutorial/blob/master/images/ansible-tutorial/Dockerfile) dans ce même repo.

**host0.example.org**, **host1.example.org** et **host2.example.org** sont les conteneurs basés sur Ubuntu 18.04 qui agissent comme des nœuds exploitables. Ces nœuds ont déjà été approvisionnés avec la clé ssh du conteneur **ansible.tutorial**. Ainsi, vous n'avez pas à vous occuper de l'installation des clés. Cette image est disponible sur [https://hub.docker.com/repository/docker/goffinet/ubuntu-1804-ansible-docker-host](https://hub.docker.com/repository/docker/goffinet/ubuntu-1804-ansible-docker-host) et le [Dockerfile](https://github.com/goffinet/ansible-interactive-tutorial/blob/master/images/ubuntu-1804-ansible-docker-host/Dockerfile) est dans ce repo.

### Port Mapping

Il y a des checkpoints dans les tutoriels où vous pouvez vérifier et vérifier vos déploiements. A cet effet, certains ports des conteneurs sont exposés comme ports hôtes comme suit :

Conteneur|Port du conteneur|Port de l'hôte
:---|:---:|:---:
host0.example.org|80|`$HOSTPORT_BASE`  
host1.example.org|80|`$HOSTPORT_BASE+1`
host2.example.org|80|`$HOSTPORT_BASE+2`
host0.example.org|8080|`$HOSTPORT_BASE+3`
host1.example.org|30000|`$HOSTPORT_BASE+4`
host2.example.org|443|`$HOSTPORT_BASE+5`

La variable `HOSTPORT_BASE` est fixée à la valeur `42726` par défaut et peut être changée en démarrant le tutoriel comme suit :

```bash
./tutorial.sh --remove # Make sure you shut down the previous ones
HOSTPORT_BASE=<some_other_value> ./tutorial.sh
```

### Dossier de l'espace de travail Workspace

Un dossier `ansible-interactive-tutorial/workspace` sur votre machine locale est monté en tant que `/root/workspace` dans le conteneur **ansible.tutorial**. Ainsi, vous pouvez utiliser votre éditeur favori sur votre machine locale pour éditer des fichiers. L'édition de fichiers n'est cependant pas nécessaire pour suivre les leçons.
