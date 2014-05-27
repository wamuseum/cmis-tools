<?php

if (!defined("__CA_DB_HOST__")) {
	define("__CA_DB_HOST__", 'localhost');
}
if (!defined("__CA_DB_USER__")) {
	define("__CA_DB_USER__", 'ca_test');
}
if (!defined("__CA_DB_PASSWORD__")) {
	define("__CA_DB_PASSWORD__", 'password');
}
if (!defined("__CA_DB_DATABASE__")) {
	define("__CA_DB_DATABASE__", 'ca_test');
}

require_once(getenv('COLLECTIVEACCESS_HOME') . '/setup.php');
