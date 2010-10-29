# ActiveResource workaround for Rails 2.x
# https://rails.lighthouseapp.com/projects/8994/tickets/1472-activeresource-222-errorsfrom_xml-cant-handle-symboled-attribute-keys-because-of-humanize-call
#
class Symbol
  def humanize
    to_s.humanize
  end
end