# Set up avahi so that your VM announces its SSH service to the Mac using Bonjour

# Required package
avahi-daemon:
  pkg:
    - installed
  service:
    - enabled

{% for service in ['ssh', 'http'] %}
The easy way in for {{ service }}:
  file:
    - managed
    - name: /etc/avahi/services/{{ service }}.service
    - source: salt://avahi/{{ service }}.service
    - template: jinja
{% endfor %}

To get avahi to start in a headless machine, we need to disable dbus support:
  file:
    - replace
    - name: /etc/avahi/avahi-daemon.conf
    - pattern: .*enable-dbus=.*
    - repl: enable-dbus=no
    - watch_in:
      - service: avahi-daemon

Ensure Bonjour advertisements only go out via eth1:
  file:
    - replace
    - name: /etc/avahi/avahi-daemon.conf
    - pattern: .*allow-interfaces=.*
    - repl: allow-interfaces=eth1
    - watch_in:
      - service: avahi-daemon

