require 'erb'
require 'polycon/models/appointment'

# Build template data class.
class Export
  def initialize( date )
    @date = date
    #@turnos = []
    @fulldate= []
    @name = []
    @surname = []
    @phone = []
  
  end

  def add_feature( date, name, surname, phone )
    date = date.delete!".paf"
    @fulldate<< date
    @name << name+" "+surname+" "+phone
    @surname << surname
    @phone << phone
  end

  # Support templating of member data.
  def get_binding
    binding
  end

  # ...

  def export(date, professional)
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
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "08:00"} %>
      <% if (turno!=nil)%>
      <td headers="date 08" > <%= @name[turno] %></td>
      <% else%>
      <td headers="date 08" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "09:00"} %>
      <% if (turno!=nil)%>
      <td headers="date 09" > <%= @name[turno]%></td>
      <% else%>
      <td headers="date 09" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "10:00"} %>
      <td headers="date 10" > <%=  %></td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "11:00"} %>
      <td headers="date 11" > <%= %></td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "12:00"} %>
      <td headers="date 12" > <%=  %></td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "13:00"} %>
      <td headers="date 12" > <%=  %></td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "14:00"} %>
      <td headers="date 14" > <%=  %></td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "15:00"} %>
      <td headers="date 15" > <%=  %></td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "16:00"} %>
      <td headers="date 16" > <%= %></td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "17:00"} %>
      <td headers="date 17" > <%=  %></td>
      </tr>
      </tbody>
    </table>
  </body>
</html>

  </html>
}.gsub(/^  /, '')

rhtml = ERB.new(template)

# Set up template data.
#grilla = Export.new(date)
                   

lista = Polycon::Models::Appointment.showexport(date,professional)
puts lista.size
lista.each do |clave|
 self.add_feature(clave[:date],clave[:name], clave[:surname], clave[:phone])
 #puts clave[:name]
 #puts clave[:surname]
 #puts clave[:phone]
end

# Produce result.
 rhtml.run(self.get_binding)
end

end