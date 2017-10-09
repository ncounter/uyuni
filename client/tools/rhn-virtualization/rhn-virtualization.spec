# package renaming fun :(
%define rhn_client_tools spacewalk-client-tools
%define rhn_setup	 spacewalk-client-setup
%define rhn_check	 spacewalk-check
%define rhnsd		 spacewalksd
#
%define rhn_dir %{_datadir}/rhn
%define rhn_conf_dir %{_sysconfdir}/sysconfig/rhn
%define cron_dir %{_sysconfdir}/cron.d

%if 0%{?fedora} || 0%{?suse_version} > 1320
%global build_py3   1
%global default_py3 1
%endif

%define pythonX %{?default_py3: python3}%{!?default_py3: python2}

Name:           rhn-virtualization
Summary:        Spacewalk action support for virualization
Version:        5.4.63
Release:        1%{?dist}

Group:          System Environment/Base
License:        GPLv2
URL:            https://github.com/spacewalkproject/spacewalk
Source0:        https://github.com/spacewalkproject/spacewalk/archive/%{name}-%{version}.tar.gz
Source1:        %{name}-rpmlintrc

BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
%if 0%{?fedora} || 0%{?rhel} || 0%{?suse_version} >= 1210
BuildArch:      noarch
%endif
%if 0%{?suse_version}
# make chkconfig work in OBS
BuildRequires: sysconfig syslog
%endif

%description
rhn-virtualization provides various Spacewalk actions for manipulation
virtual machine guest images.

%package -n python2-%{name}-common
Summary: Files needed by rhn-virtualization-host
%{?python_provide:%python_provide python2-%{name}-common}
Provides: python-%{name}-common = %{version}-%{release}
Obsoletes: python-%{name}-common < %{version}-%{release}
Provides: %{name}-common = %{version}-%{release}
Obsoletes: %{name}-common < %{version}-%{release}
Requires: python2-rhn-client-tools
Requires: spacewalk-usix
BuildRequires: python
%if 0%{?suse_version}
# aaa_base provide chkconfig
Requires: aaa_base
# provide directories for filelist check in obs
BuildRequires: rhn-client-tools rhn-check
%else
Requires: chkconfig
%endif
%description -n python2-%{name}-common
This package contains files that are needed by the rhn-virtualization-host
package.

%if 0%{?build_py3}
%package -n python3-%{name}-common
Summary: Files needed by rhn-virtualization-host
Obsoletes: %{name}-common < %{version}-%{release}
Requires: python3-spacewalk-usix
Requires: python3-rhn-client-tools
BuildRequires: python3-devel
%description -n python3-%{name}-common
This package contains files that are needed by the rhn-virtualization-host
package.
%endif

%package host
Summary: Spacewalk Virtualization support specific to the Host system
Group: System Environment/Base
Requires: %{pythonX}-%{name}-host = %{version}-%{release}
%if 0%{?suse_version}
Requires: cron
%else
Requires: /usr/sbin/crond
%endif

%description host
This package contains code for Spacewalk's Virtualization support
that is specific to the Host system (a.k.a. Dom0).

%package -n python2-%{name}-host
Summary: RHN/Spacewalk Virtualization support specific to the Host system
Requires: %{name}-host = %{version}-%{release}
Requires: libvirt-python
Requires: python2-%{name}-common = %{version}-%{release}
%if 0%{?suse_version}
Requires: python-curl
%else
Requires: python-pycurl
%endif
%description -n python2-%{name}-host
Python 2 files for %{name}-host.

%if 0%{?build_py3}
%package -n python3-%{name}-host
Summary: RHN/Spacewalk Virtualization support specific to the Host system
Requires: %{name}-host = %{version}-%{release}
Requires: libvirt-python3
Requires: python3-%{name}-common = %{version}-%{release}
Requires: python3-pycurl
%description -n python3-%{name}-host
Python 3 files for %{name}-host.
%endif

%prep
%setup -q

%build
make -f Makefile.rhn-virtualization


%install
rm -rf $RPM_BUILD_ROOT
make -f Makefile.rhn-virtualization DESTDIR=$RPM_BUILD_ROOT PKGDIR0=%{_initrddir} \
        PYTHONPATH=%{python_sitelib} install
sed -i 's,@PYTHON@,python,; s,@PYTHONPATH@,%{python_sitelib},;' \
        $RPM_BUILD_ROOT/%{_initrddir}/rhn-virtualization-host \
        $RPM_BUILD_ROOT/%{cron_dir}/rhn-virtualization.cron

%if 0%{?build_py3}
make -f Makefile.rhn-virtualization DESTDIR=$RPM_BUILD_ROOT PKGDIR0=%{_initrddir} \
        PYTHONPATH=%{python3_sitelib} install
        sed -i 's,@PYTHON@,python3,; s,@PYTHONPATH@,%{python3_sitelib},;' \
                $RPM_BUILD_ROOT/%{_initrddir}/rhn-virtualization-host \
                $RPM_BUILD_ROOT/%{cron_dir}/rhn-virtualization.cron
%endif

%if 0%{?fedora} || (0%{?rhel} && 0%{?rhel} > 5)
find $RPM_BUILD_ROOT -name "localvdsm*" -exec rm -f '{}' ';'
%endif

%if 0%{?suse_version}
rm -f $RPM_BUILD_ROOT/%{_initrddir}/rhn-virtualization-host
%endif

%if 0%{?suse_version}
%py_compile %{buildroot}/%{python_sitelib}
%py_compile -O %{buildroot}/%{python_sitelib}
%if 0%{?build_py3}
%py3_compile %{buildroot}/%{python3_sitelib}
%py3_compile -O %{buildroot}/%{python3_sitelib}
%endif
%endif

%clean
rm -rf $RPM_BUILD_ROOT

%if 0%{?suse_version}

%post host
if [ -d /proc/xen ]; then
    # xen kernel is running
    # change the default template to the xen version
    sed -i 's@^IMAGE_CFG_TEMPLATE=/etc/sysconfig/rhn/studio-kvm-template.xml@IMAGE_CFG_TEMPLATE=/etc/sysconfig/rhn/studio-xen-template.xml@' /etc/sysconfig/rhn/image.cfg
fi

%else
%post host
/sbin/chkconfig --add rhn-virtualization-host
/sbin/service crond condrestart
if [ -d /proc/xen ]; then
    # xen kernel is running
    # change the default template to the xen version
    sed -i 's@^IMAGE_CFG_TEMPLATE=/etc/sysconfig/rhn/studio-kvm-template.xml@IMAGE_CFG_TEMPLATE=/etc/sysconfig/rhn/studio-xen-template.xml@' /etc/sysconfig/rhn/image.cfg
fi

%preun host
if [ $1 = 0 ]; then
  /sbin/chkconfig --del rhn-virtualization-host
fi

%postun host
/sbin/service crond condrestart
%endif

%files -n python2-%{name}-common
%defattr(-,root,root,-)
%dir %{python_sitelib}/virtualization
%{python_sitelib}/virtualization/__init__.py*
%{python_sitelib}/virtualization/batching_log_notifier.py*
%{python_sitelib}/virtualization/constants.py*
%{python_sitelib}/virtualization/errors.py*
%{python_sitelib}/virtualization/notification.py*
%{python_sitelib}/virtualization/util.py*
%doc LICENSE

%if 0%{?build_py3}
%files -n python3-%{name}-common
%defattr(-,root,root,-)
%dir %{python3_sitelib}/virtualization
%{python3_sitelib}/virtualization/__init__.py*
%{python3_sitelib}/virtualization/batching_log_notifier.py*
%{python3_sitelib}/virtualization/constants.py*
%{python3_sitelib}/virtualization/errors.py*
%{python3_sitelib}/virtualization/notification.py*
%{python3_sitelib}/virtualization/util.py*
%doc LICENSE
%dir %{python3_sitelib}/virtualization/__pycache__
%{python3_sitelib}/virtualization/__pycache__/__init__.*
%{python3_sitelib}/virtualization/__pycache__/batching_log_notifier.*
%{python3_sitelib}/virtualization/__pycache__/constants.*
%{python3_sitelib}/virtualization/__pycache__/errors.*
%{python3_sitelib}/virtualization/__pycache__/notification.*
%{python3_sitelib}/virtualization/__pycache__/util.*
%endif

%files host
%defattr(-,root,root,-)
%if 0%{?suse_version}
%dir %{rhn_conf_dir}
%endif
%dir %{rhn_conf_dir}/virt
%dir %{rhn_conf_dir}/virt/auto
%if ! 0%{?suse_version}
%{_initrddir}/rhn-virtualization-host
%endif
%config(noreplace) %attr(644,root,root) %{cron_dir}/rhn-virtualization.cron
%{rhn_conf_dir}/studio-*-template.xml
%config(noreplace) %{rhn_conf_dir}/image.cfg
%doc LICENSE

%files -n python2-%{name}-host
%defattr(-,root,root,-)
%{python_sitelib}/virtualization/domain_config.py*
%{python_sitelib}/virtualization/domain_control.py*
%{python_sitelib}/virtualization/domain_directory.py*
%{python_sitelib}/virtualization/get_config_value.py*
%{python_sitelib}/virtualization/init_action.py*
%{python_sitelib}/virtualization/poller.py*
%{python_sitelib}/virtualization/schedule_poller.py*
%{python_sitelib}/virtualization/poller_state_cache.py*
%{python_sitelib}/virtualization/start_domain.py*
%{python_sitelib}/virtualization/state.py*
%{python_sitelib}/virtualization/support.py*
%{python_sitelib}/rhn/actions/virt.py*
%{python_sitelib}/rhn/actions/image.py*
%if 0%{?suse_version} || (0%{?rhel} && 0%{?rhel} < 6)
%{python_sitelib}/virtualization/localvdsm.py*
%endif

%if 0%{?build_py3}
%files -n python3-%{name}-host
%defattr(-,root,root,-)
%{python3_sitelib}/virtualization/domain_config.py*
%{python3_sitelib}/virtualization/domain_control.py*
%{python3_sitelib}/virtualization/domain_directory.py*
%{python3_sitelib}/virtualization/get_config_value.py*
%{python3_sitelib}/virtualization/init_action.py*
%{python3_sitelib}/virtualization/poller.py*
%{python3_sitelib}/virtualization/schedule_poller.py*
%{python3_sitelib}/virtualization/poller_state_cache.py*
%{python3_sitelib}/virtualization/start_domain.py*
%{python3_sitelib}/virtualization/state.py*
%{python3_sitelib}/virtualization/support.py*
%{python3_sitelib}/rhn/actions/virt.py*
%{python3_sitelib}/rhn/actions/image.py*
%{python3_sitelib}/virtualization/__pycache__/domain_config.*
%{python3_sitelib}/virtualization/__pycache__/domain_control.*
%{python3_sitelib}/virtualization/__pycache__/domain_directory.*
%{python3_sitelib}/virtualization/__pycache__/get_config_value.*
%{python3_sitelib}/virtualization/__pycache__/init_action.*
%{python3_sitelib}/virtualization/__pycache__/poller.*
%{python3_sitelib}/virtualization/__pycache__/schedule_poller.*
%{python3_sitelib}/virtualization/__pycache__/poller_state_cache.*
%{python3_sitelib}/virtualization/__pycache__/start_domain.*
%{python3_sitelib}/virtualization/__pycache__/state.*
%{python3_sitelib}/virtualization/__pycache__/support.*
%{python3_sitelib}/rhn/actions/__pycache__/virt.*
%{python3_sitelib}/rhn/actions/__pycache__/image.*
%endif

%changelog
* Fri Oct 06 2017 Michael Mraka <michael.mraka@redhat.com> 5.4.63-1
- virt modules (and deps) are now in standard python path

* Fri Oct 06 2017 Michael Mraka <michael.mraka@redhat.com> 5.4.62-1
- install files into python_sitelib/python3_sitelib
- move rhn-virtualization-host files into proper python2/python3 subpackages
- move rhn-virtualization-common files into proper python2/python3 subpackages
- split rhn-virtualization-host into python2/python3 specific packages
- split rhn-virtualization into python2/python3 specific packages

* Wed Sep 06 2017 Michael Mraka <michael.mraka@redhat.com> 5.4.61-1
- purged changelog entries for Spacewalk 2.0 and older

* Wed Aug 09 2017 Michael Mraka <michael.mraka@redhat.com> 5.4.60-1
- precompile py3 bytecode on Fedora 23+
- use standard brp-python-bytecompile

* Tue Jul 18 2017 Michael Mraka <michael.mraka@redhat.com> 5.4.59-1
- move version and release before sources

* Mon Jul 17 2017 Jan Dobes 5.4.58-1
- Updated links to github in spec files
- Migrating Fedorahosted to GitHub

* Wed Feb 15 2017 Tomas Kasparek <tkasparek@redhat.com> 5.4.57-1
- require spacewalk-usix indead of spacewalk-backend-usix

* Wed Oct 19 2016 Gennadii Altukhov <galt@redhat.com> 5.4.56-1
- 1379891 - make rhn-virtualization code compatible with Python 2/3

* Tue Jan 13 2015 Matej Kollar <mkollar@redhat.com> 5.4.55-1
- Getting rid of Tabs and trailing spaces in LICENSE, COPYING, and README files

* Fri Jul 11 2014 Milan Zazrivec <mzazrivec@redhat.com> 5.4.54-1
- fix copyright years

* Wed Apr 23 2014 Stephen Herr <sherr@redhat.com> 5.4.53-1
- 1089715 - some systems to not have /sbin in path

* Tue Apr 22 2014 Stephen Herr <sherr@redhat.com> 5.4.52-1
- 1089715 - service location is not platform independent

* Mon Apr 21 2014 Stephen Herr <sherr@redhat.com> 5.4.51-1
- 1089715 - rhn-virt-host should not spam root if libvirtd is stopped

* Mon Sep 30 2013 Michael Mraka <michael.mraka@redhat.com> 5.4.50-1
- removed trailing whitespaces

* Tue Sep 17 2013 Michael Mraka <michael.mraka@redhat.com> 5.4.49-1
- Grammar error occurred

* Wed Jul 17 2013 Tomas Kasparek <tkasparek@redhat.com> 5.4.48-1
- updating copyright years

* Wed Jun 12 2013 Tomas Kasparek <tkasparek@redhat.com> 5.4.47-1
- rebranding RHN Satellite to Red Hat Satellite in client stuff

* Fri May 03 2013 Tomas Lestach <tlestach@redhat.com> 5.4.46-1
- 915287 - python 2.4 does not know 'exit'
- 915287 - define a utf8_encode wrapper

* Thu Mar 28 2013 Jan Pazdziora 5.4.45-1
- isInstallerConfig should check for autoyast in commandline
- catch libvirtError to return meaningfull error messages

* Thu Feb 07 2013 Stephen Herr <sherr@redhat.com> 5.4.44-1
- 908899 - rhn-virtualization-host needs to consistantly use the new function
  definition

* Wed Feb 06 2013 Jan Pazdziora 5.4.43-1
- support studio KVM image type

