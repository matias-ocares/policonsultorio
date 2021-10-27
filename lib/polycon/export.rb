require 'erb'
require 'polycon/models/appointment'

# Build template data class.
class Export
  def initialize( date )
    @date = date
   
    @turnos = [ ]
  end

  def add_feature( turno )
    @turnos << turno
  end

  # Support templating of member data.
  def get_binding
    binding
  end

  # ...

  def self.export(date, professional)
# Create template.
template = %{
  <html>
   
    <html>
  <head>
    <style>
      table {
        border-collapse: collapse;
      }
      td, th {
        border: 1px solid black;
        padding: 1em;
      }
    </style>
  </head>
  <body>
    <h1>Ruby Study Group</h1>
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>08:00</th>
          <th>09:00</th>
          <th>10:00</th>
          <th>11:00</th>
          <th>12:00</th>
          <th>13:00</th>
          <th>14:00</th>
          <th>15:00</th>
          <th>16:00</th>
          <th>17:00</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td> <%= @date %> </td>
          <% @turnos.each do |t| %> 
            <% if (t.split(" ")[1] == "08:00") %>          
          <td><%= t %></td>
          <% else %>
          <td><%= " " %></td>
          <% end %>
          <% end %>
          <% @turnos.each do |t| %> 
            <% if (t.split(" ")[1] == "09:00") %>          
          <td><%= t %></td>
          <% else %>
          <td><%= " " %></td>
          <% end %>
          <% end %>
          <% @turnos.each do |t| %> 
            <% if (t.split(" ")[1] == "10:00") %>          
          <td><%= t %></td>
          <% else %>
          <td><%= " " %></td>
          <% end %>
          <% end %>
          <% @turnos.each do |t| %> 
            <% if (t.split(" ")[1] == "11:00") %>          
          <td><%= t %></td>
          <% else %>
          <td><%= " " %></td>
          <% end %>
          <% end %>
          <% @turnos.each do |t| %> 
            <% if (t.split(" ")[1] == "12:00") %>          
          <td><%= t %></td>
          <% else %>
          <td><%= " " %></td>
          <% end %>
          <% end %>
        </tr>
      </tbody>
    </table>
  </body>
</html>

  </html>
}.gsub(/^  /, '')

rhtml = ERB.new(template)

# Set up template data.
toy = Export.new(date)
                   


lista = Polycon::Models::Appointment.list(professional)
lista.each do |turno|
  toy.add_feature(turno)
end

# Produce result.

    rhtml.run(toy.get_binding)
end

end