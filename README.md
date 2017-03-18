# Tournament

## What is it?
 Pyhon program that simulates a [swiss system tournament](https://en.wikipedia.org/wiki/Swiss-system_tournament).

## Installation steps
 Please follow the steps below:

### Pre-requisites:
 * Python 2.7 - https://www.python.org/downloads/
 * Any text editor for editing the code(Sublime text preferred - https://www.sublimetext.com/download)
 * [Vagrant](https://www.vagrantup.com/)
 * [Virtual box - v4.3 preferred](https://www.virtualbox.org/)
 * [Git](https://git-scm.com/downloads)

### Steps
 1. Clone [Udacity Full Stack Nano Degree VM Repository](https://github.com/udacity/fullstack-nanodegree-vm)
 2. Launch [Vagrant VM](https://www.vagrantup.com/docs/)
    * Run 'vagrant up' command in the 'Udacity Full Stack Nano Degree VM Repository' clone folder
     (It may take a while to complete if you have never run it before)
    * Run 'vagrant ssh' command
    * Navigate to /vagrant/tournament/ folder
 3. Run 'psql -f tournament.sql' command to create tournament database with all tables
 4. Make changes to SQL database and table definitions file ([tournament.sql](https://github.com/ahmfrz/Tournament/blob/master/tournament.sql))
 5. Make changes to Python functions ([tournament.py](https://github.com/ahmfrz/Tournament/blob/master/tournament.py))
 6. Run test suite to verify your code ([tournament_test.py](https://github.com/ahmfrz/Tournament/blob/master/tournament_test.py))

 #### Note:
 Files with _multi.xxx suffix support multi-tournaments

## How to Contribute

Find any bugs? Have suggestions? Contributions are welcome!

First, fork this repository.

![Fork Icon](fork-icon.png)

Next, clone this repository to your desktop to make changes.

```sh
$ git clone {YOUR_REPOSITORY_CLONE_URL}
$ cd folder
```

Once you've pushed changes to your local repository, you can issue a pull request by clicking on the green pull request icon.

![Pull Request Icon](pull-request-icon.png)

## License

The contents of this repository are covered under the [MIT License](LICENSE).
