import * as React from "react";

type Props = {
  type: string;
  className?: string;
  title?: string;
};

function IconTag(props: Props) {
  const icons = {
    "action-failed": {label: "cancel", styles: "fa-1-5x text-danger"},
    "action-ok": {label: "check_circle", styles: "fa-1-5x text-success"},
    "action-pending": {label: "schedule", styles: "fa-1-5x"},
    "action-running": {label: "swap_horiz", styles: "fa-1-5x"},
    "errata-bugfix": {label: "bug_report", styles: "fa-1-5x"},
    "errata-enhance": {label: "enhancement", styles: "fa-1-5x"},
    "errata-security": {label: "security", styles: "fa-1-5x"},
    "errata-reboot": {label: "sync", styles: "fa-1-5x"},
    "errata-restart": {label: "namespace", styles: "fa-1-5x"},
    "event-type-errata": {label: "healing"},
    "event-type-package": {label: "package"},
    "event-type-preferences": {label: "settings"},
    "event-type-system": {label: "desktop_mac"},
    "file-directory": {label: "folder_open"},
    "file-file": {label: "description"},
    "file-symlink": {label: "symlink"},
    "header-action": {label: "schedule"},
    "header-activation-key": {label: "vpn_key"},
    "header-calendar": {label: "today"},
    "header-chain": {label: "action_chains"},
    "header-channel": {label: "tune"},
    "header-channel-configuration": {label: "settings tune"},
    "header-channel-mapping": {label: "repeat"},
    "header-chat": {label: "chat_bubble", styles: "text-primary"},
    "header-clock": {label: "schedule"},
    "header-config-system": {label: "settings"},
    "header-configuration": {label: "configuration_file"},
    "header-crash": {label: "critical_bug"},
    "header-errata": {label: "healing"},
    "header-errata-add": {label: "add healing"},
    "header-errata-del": {label: "remove healing"},
    "header-errata-set": {label: "miscellaneous"},
    "header-errata-set-add": {label: "add miscellaneous"},
    "header-event-history": {label: "timeline"},
    "header-file": {label: "description"},
    "header-folder": {label: "folder_open"},
    "header-globe": {label: "language"},
    "header-help": {label: "help"},
    "header-info": {label: "info"},
    "header-kickstart": {label: "bootstrapping"},
    "header-list": {label: "format_list_bulleted"},
    "header-multiorg-big": {label: "organization", styles: "fa-3x"},
    "header-note": {label: "sticky_note"},
    "header-organisation": {label: "group"},
    "header-package": {label: "package"},
    "header-package-add": {label: "add package"},
    "header-package-del": {label: "remove package"},
    "header-package-extra": {label: "miscellaneous"},
    "header-package-upgrade": {label: "package_upgrade"},
    "header-power": {label: "power_settings_new"},
    "header-preferences": {label: "miscellaneous_services"},
    "header-proxy": {label: "proxy"},
    "header-refresh": {label: "sync"},
    "header-reloading": {label: "autorenew", styles: "fa-spin"},
    "header-sandbox": {label: "sandbox"},
    "header-schedule": {label: "date_range"},
    "header-search": {label: "search"},
    "header-signout": {label: "exit_to_app"},
    "header-sitemap": {label: "config_map"},
    "header-snapshot": {label: "camera"},
    "header-snapshot-rollback": {label: "snapshot_rollback"},
    "header-subscriptions-big": {label: "subscriptions", styles: "fa-3x"},
    "header-symlink": {label: "symlink"},
    "header-system": {label: "desktop_mac"},
    "header-system-groups": {label: "system_group"},
    "header-system-physical": {label: "desktop_map"},
    "header-system-virt-guest": {label: "virtual_guest"},
    "header-system-virt-host": {label: "widgets"},
    "header-taskomatic": {label: "analytics"},
    "header-user": {label: "person"},
    "header-users-big": {label: "group", styles: "fa-3x"},
    "item-add": {label: "add"},
    "item-clone": {label: "content_copy"},
    "item-del": {label: "delete"},
    "item-disabled": {label: "do_not_disturb", styles: "text-muted"},
    "item-download": {label: "file_download"},
    "item-download-csv": {label: "csv_file"},
    "item-edit": {label: "edit"},
    "item-enabled": "fa fa-check text-success",
    "item-enabled-pending": "fa fa-hand-o-right text-success",
    "item-import": "fa fa-level-down",
    "item-search": "fa fa-eye",
    "item-ssm-add": "fa fa-plus-circle",
    "item-ssm-del": "fa fa-minus-circle",
    "item-upload": "fa fa-upload",
    "item-order": "fa fa-sort",
    "item-error": "fa fa-times text-danger",
    "item-error-pending": "fa fa-hand-o-right text-danger",
    "nav-bullet": "fa fa-caret-right",
    "nav-page-first": "fa fa-angle-double-left",
    "nav-page-last": "fa fa-angle-double-right",
    "nav-page-next": "fa fa-angle-right",
    "nav-page-prev": "fa fa-angle-left",
    "nav-right": "fa fa-arrow-right",
    "nav-up": "fa fa-caret-up",
    "repo-sync": "fa fa-refresh",
    "repo-schedule-sync": "fa fa-calendar",
    "scap-nochange": "fa fa-dot-circle-o fa-1-5x text-info",
    "setup-wizard-creds-edit": "fa fa-pencil",
    "setup-wizard-creds-failed": "fa fa-times-circle-o text-danger",
    "setup-wizard-creds-make-primary": "fa fa-star-o text-starred",
    "setup-wizard-creds-primary": "fa fa-star text-starred",
    "setup-wizard-creds-subscriptions": "fa fa-th-list",
    "setup-wizard-creds-verified": "fa fa-check-square text-success",
    "sort-down": "fa fa-arrow-circle-down",
    "sort-up": "fa fa-arrow-circle-up",
    spinner: "fa fa-spinner fa-spin",
    "system-state": "fa spacewalk-icon-salt-add",
    "system-bare-metal-legend": "fa fa-1-5x spacewalk-icon-bare-metal",
    "system-bare-metal": "fa spacewalk-icon-bare-metal",
    "system-crit": "fa fa-exclamation-circle fa-1-5x text-danger",
    "system-kickstarting": "fa fa-rocket fa-1-5x",
    "system-locked": "fa fa-lock fa-1-5x",
    "system-ok": "fa fa-check-circle fa-1-5x text-success",
    "system-physical": "fa fa-desktop fa-1-5x",
    "system-reboot": "fa fa-refresh",
    "system-unentitled": "fa fa-times-circle fa-1-5x",
    "system-unknown": "fa fa-question-circle fa-1-5x",
    "system-virt-guest": "fa fa-1-5x spacewalk-icon-virtual-guest",
    "system-virt-host": "fa fa-1-5x spacewalk-icon-virtual-host",
    "system-warn": "fa fa-exclamation-triangle fa-1-5x text-warning",
    "fa-home": {label: "home"},
    "fa-desktop": {label: "desktop_mac"},
    "spacewalk-icon-patches": {label: "healing"},
    "spacewalk-icon-software-channels": {label: "tune"},
    "spacewalk-icon-software-channel-management": {label: "settings tune"},
    "fa-clock-o": {label: "schedule"},
    "spacewalk-icon-lifecycle": {label: "content_lifecycle_management"},
    "spacewalk-icon-manage-configuration-files": {label: "configuration_file"},
    "spacewalk-icon-clusters": {label: "cluster_role"},
  };

  if (Object.keys(icons).includes(props.type)) {
    if (icons[props.type].label) {
      return <i className={"eos-icons " + (icons[props.type].styles ?? "") + " " + (props.className ?? "")} title={props.title}>{icons[props.type].label}</i>;
    }
    else {
      return <i className={"fa " + icons[props.type] + " " + (props.className ?? "")} title={props.title}></i>;
    }
  }
  else {
    return <i className={"fa " + props.type} />;
  }
}

export { IconTag };
