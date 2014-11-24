<?php

error_reporting(E_ALL);
ini_set('display_errors', TRUE);
ini_set('display_startup_errors', TRUE);

$databases = array (
  'default' =>
  array (
    'default' =>
    array (
      'database' => 'drupal',
      'username' => 'root',
      'password' => 'root',
      'host' => 'localhost',
      'port' => '',
      'driver' => 'mysql',
      'prefix' => '',
    ),
  ),
);

$databases['bmj_d6']['default'] = array(
  'username' => 'drupaldev',
  'password' => 'A11r0dZ',
  'database' => 'drupal_prod_jnl_bmj',
  'host'   => 'drupal-dev-mysql01.highwire.org',
  'driver' => 'mysql',
);


// Place holder for $conf settings alterations by JCORE install script
$conf = array();

/**
 * Highwire settings
 */
$conf['highwire_sitecode'] = 'jnl-bmj';

/**
 * HighWire Service Passwords and options
 *
 * These should be enabled set for all installations
 */
$databases['highwire_a4d_connection']['default'] = array(
  'username' => 'drupal',
  'password' => 'fAstHuckle!',
  'database' => 'a4d',
  'host'   => 'a4d-mysql-1.highwire.org',
  'payload'  => 'resource_payload',
  'driver' => 'mysql',
);

/**
 * Solr -- set your solr server here
 * Production solr is at drupal-prod-solr01.highwire.org
 */
$conf['apachesolr_environments']['solr']['url'] = 'http://drupal-dev-solr01.highwire.org:8080/solr-bmj-d7-solr4/';

/**
 * MemCache -- uncomment to enable memcache
 */
$conf['cache_default_class'] = 'MemCacheDrupal';
$conf['cache_backends'][] = 'sites/all/modules/contrib/memcache/memcache.inc';
$conf['memcache_servers'] = array('127.0.0.1:11211' => 'default');
$conf['lock_inc'] = 'sites/all/modules/contrib/memcache/memcache-lock.inc';

/**
 * PHP settings:
 */
ini_set('session.gc_probability', 1);
ini_set('session.gc_divisor', 100);
ini_set('session.gc_maxlifetime', 200000);
ini_set('session.cookie_lifetime', 2000000);

/**
 * Authorized file system operations:
 *
 * Some sites might wish to disable the above functionality, and only update
 * the code directly via SSH or FTP themselves. This setting completely
 * disables all functionality related to these authorized file operations.
 *
 * @see http://drupal.org/node/244924
 *
 * Remove the leading hash signs to disable.
 */
$conf['allow_authorize_operations'] = FALSE;

/**
 * Set database to use utf8mb4 character set
 */
foreach($databases as $db_key1 =>$database){
  foreach($database as $db_key2 => $db){
    $databases[$db_key1][$db_key2]['charset'] = 'utf8mb4';
  }
}

/**
 * Generate unique prefix keys for Memcache
 * We also use this string as the salt for this site
 */
if (isset($conf['highwire_sitecode'])) {
  $conf['highwire_prefix_key'] = str_replace('-','_',$conf['highwire_sitecode']) . '_' . substr(md5(serialize($databases['default']['default']).$conf['highwire_sitecode']),0,8);
}
else {
  $conf['highwire_prefix_key'] = 'unknown' . '_' . substr(md5(serialize($databases['default']['default'])),0,8);
}
$conf['memcache_key_prefix'] = $conf['highwire_prefix_key'];

/*
 * Stop populating Drupal's internal search index since we never use it.
 */
$conf['search_cron_limit'] = 0;


/**
 * Specify every reverse proxy IP address in your environment.
 * This setting is required if $conf['reverse_proxy'] is TRUE.
 */
$conf['reverse_proxy_addresses'] = array (
  '127.0.0.1',
  '171.67.122.61',  // drupal-loadbal
  '171.67.122.7',   // drupal-varnish01
  '171.67.122.60',  // drupal-varnish
  '171.67.125.190', // drupal-prod-varnish01
  '171.67.125.225', // drupal-prod-varnish02
  '171.67.125.35',  // F5
  '171.67.123.251', // F5 - bmj-beta
  '171.66.121.6',   // F5 - BMJ
  '171.66.121.222', // F5 - BMJ#2
  '171.66.124.147', // F5 - BMJ#3
  '171.67.126.77',  // F5 - BMJ#4
  '171.67.115.68',  // F5 - hw-f5-jbjs.highwire.org
);

/**
 * HighWire overrides for file chmod
 * This makes backup and management really easy
 */
$conf['file_chmod_directory'] = 0777;
$conf['file_chmod_file'] = 0777;


/**
 * Compute the cookie_domain from all available ones
 * Set the $cookie_domains array above to use this.
 */
if (!empty($cookie_domains)) {
  foreach ($cookie_domains as $domain) {
    if (strpos($_SERVER['SERVER_NAME'], $domain) !== FALSE) {
      $cookie_domain = '.'.$domain;
      break;
    }
  }
}


/**
 * Disable poormans cron
 */
$conf['cron_safe_threshold'] = 0;


/**
 * Access control for update.php script.
 * This should always be FALSE as we should be doing updates via drush
 */
$update_free_access = FALSE;

/**
 * Allow image derivaties to be derived without tokens
 * See http://drupal.org/drupal-7.21-release-notes
 */
$conf['image_allow_insecure_derivatives'] = TRUE;

/**
* Sync local images from the dev/staging sites
*
*/
$conf['stage_file_proxy_origin'] = 'http://www.bmj.com';
$conf['highwire_variant_functions'] = array('jnl_bmj_print_highwire_variants');

/**
 * Salt for one-time login links and cancel links, form tokens, etc.
 * We set it to be the same as the memcache_key_prefix so that it is unique for each site
 */
$drupal_hash_salt = 'F4ofLxAs4sGKuAruRM_LF0sGM79DEado7sLZzJJYJLY';

