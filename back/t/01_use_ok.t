use Test::More;
use lib 'lib';

BEGIN { 
    use_ok( 'Thnkout' ); 
    use_ok( 'Thnkout::Response' ); 
    use_ok( 'Thnkout::Request' ); 
    use_ok( 'Thnkout::Context' ); 
    use_ok( 'Thnkout::Config' ); 
    use_ok( 'Thnkout::Config::Route' ); 
    use_ok( 'Thnkout::View::Xslate' ); 
    use_ok( 'Thnkout::Engine::Index' ); 
    use_ok( 'Thnkout::DBI' ); 
    use_ok( 'Thnkout::DBI::Factory' ); 
    use_ok( 'Thnkout::Util' ); 
    use_ok( 'Thnkout::Model::User' ); 
    use_ok( 'Thnkout::Service::User' ); 
    use_ok( 'Thnkout::Service::Theme' ); 
    use_ok( 'Thnkout::Service::InfoCollection' ); 
    use_ok( 'Thnkout::Model' ); 
}
done_testing();

1;
