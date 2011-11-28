use strict;
use warnings;

package Dist::Zilla::PluginBundle::ARJONES;
{
  $Dist::Zilla::PluginBundle::ARJONES::VERSION = '1.113320';
}

# ABSTRACT: L<Dist::Zilla> plugins for ARJONES

use Moose;
use Moose::Autobox;
use Dist::Zilla 2.100922;
with 'Dist::Zilla::Role::PluginBundle::Easy';


use Dist::Zilla::PluginBundle::Basic;
use Dist::Zilla::PluginBundle::Git;

sub configure {
    my ($self) = @_;

    # @Basic has:
    #    GatherDir
    #    PruneCruft
    #    ManifestSkip
    #    MetaYAML
    #    License
    #    Readme
    #    ExtraTests
    #    ExecDir
    #    ShareDir
    #    MakeMaker
    #    Manifest
    #    TestRelease
    #    ConfirmRelease
    #    UploadToCPAN
    $self->add_bundle('@Basic');

    $self->add_plugins(
        qw(
          AutoPrereqs
          AutoVersion
          PkgVersion
          MetaJSON
          NextRelease
          PodCoverageTests
          PodSyntaxTests
          Test::Perl::Critic
          NoTabsTests
          EOLTests
          Test::Kwalitee
          )
    );

    $self->add_plugins( [ PodWeaver => { config_plugin => '@ARJONES' } ] );

    $self->add_plugins( [ GithubMeta => { issues => 1, } ], );

    # @Git has:
    #    Git::Check
    #    Git::Commit
    #    Git::Tag
    #    Git::Push
    $self->add_bundle('@Git');
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

__END__
=pod

=head1 NAME

Dist::Zilla::PluginBundle::ARJONES - L<Dist::Zilla> plugins for ARJONES

=head1 VERSION

version 1.113320

=head1 DESCRIPTION

This is the plugin bundle that ARJONES uses. It is equivalent to:

  [@Basic]

  [PodCoverageTests]
  [PodSyntaxTests]
  [Test::Perl::Critic]
  [NoTabsTests]
  [EOLTests]
  [Test::Kwalitee]

  [AutoPrereqs]

  [PodWeaver]
  [AutoVersion]
  [PkgVersion]
  [NextRelease]
  [MetaJSON]

  [GithubMeta]
  issues = 1

  [@Git]

It also adds the following as Prereqs, so I can quickly get my C<dzil> environment set up:

=over 4

=item *

L<Dist::Zilla::App::Command::cover>

=item *

L<Dist::Zilla::App::Command::perltidy>

=back

Heavily based on L<Dist::Zilla::PluginBundle::RJBS>.

=for Pod::Coverage configure

=head1 AUTHOR

Andrew Jones <andrew@arjones.co.uk>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Andrew Jones.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

