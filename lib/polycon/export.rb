require 'erb'
require 'polycon/models/appointment'

# Build template data class.
class Export
  def initialize( date )
    @date = date
   
    @turnos = []
  
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
          <th id="08">08:00</th>
          <th id="09">09:00</th>
          <th id="10">10:00</th>
          <th id="11">11:00</th>
          <th id="12">12:00</th>
          <th id="13">13:00</th>
          <th id="14">14:00</th>
          <th id="15">15:00</th>
          <th id="16">16:00</th>
          <th id="17">17:00</th>
        </tr>
      </thead>
      <tbody>
      <tr>
      <td id="date"> <%= @date %> </td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "08:00"} %>
      <td headers="date 08" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "09:00"} %>
      <td headers="date 09" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "10:00"} %>
      <td headers="date 10" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "11:00"} %>
      <td headers="date 11" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "12:00"} %>
      <td headers="date 12" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "13:00"} %>
      <td headers="date 12" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "14:00"} %>
      <td headers="date 14" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "15:00"} %>
      <td headers="date 15" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "16:00"} %>
      <td headers="date 16" > <%= turno[0] %></td>
      <% turno= @turnos.select{|t| t.split(" ")[1] == "17:00"} %>
      <td headers="date 17" > <%= turno[0] %></td>
      </tr>
      </tbody>
    </table>
  </body>
</html>

  </html>
}.gsub(/^  /, '')

rhtml = ERB.new(template)

# Set up template data.
grilla = Export.new(date)
                   


lista = Polycon::Models::Appointment.showexport(date,professional)
puts lista.size
lista.each do |clave, valor|
  puts "#{clave}: #{valor}"
end
lista.each do |turno|
  grilla.add_feature(turno)
end

# Produce result.

    rhtml.run(grilla.get_binding)
end

end