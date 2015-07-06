#!/usr/bin/perl -w

# Add component to Bugzilla

# Authors:
# Michael Huang,        June 30 2015
# Christopher Markieta, July  3 2015

# Credits: MR
# http://random-dev.blogspot.ca/2011/12/adding-bugzilla-products-and-components.html

use strict;
use lib qw(. lib);

use Bugzilla;
use Bugzilla::Product;
use Bugzilla::Component;
use Bugzilla::User;
use Bugzilla::Error;
use Bugzilla::Constants;

if (@ARGV < 2) { print "Usage: add.component.pl new_component new_summary";
exit 1;
}

#email of bugzilla account that has admin priviledges
my $login = 'markietachristopher@gmail.com';

my $component_name = $ARGV[0];
my $component_description = "";

$a = 1;

do {
  $component_description = "$component_description $ARGV[$a]";
  $a = $a + 1;
}while ($a <= $#ARGV);

print "Adding component: ", $component_name, "\n", "Description: ", $component_description, "\n";

#Login to bugzilla
my $user = new Bugzilla::User({ name => $login })
|| ThrowUserError ('invalid_username', { name => $login });

Bugzilla->set_user($user);

#Get product
my $product_name = 'LEAP';
my $product = new Bugzilla::Product({ name => $product_name });

#Create component
my $component = Bugzilla::Component->create({
  name => $component_name,
  product => $product,
  description => $component_description,
  initialowner => $login
});

