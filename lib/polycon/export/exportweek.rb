require 'erb'
require 'polycon/models/appointment'

# Build template data class.
class Export_week
  def initialize( date )
    @date = date
    #@turnos = []
    @fulldate= []
    @name = []
    @surname = []
    @phone = []
  
  end

  def add_feature( date, name, surname, phone, professional )
    date = date.delete!".paf"
    @fulldate<< date
    @name << "Name: "+name+" Surname: "+surname+" - Phone: "+phone+" Professional: "+professional
    @surname << surname
    @phone << phone
  end

  # Support templating of member data.
  def get_binding
    binding
  end

  # ...
  def get_template()
  # Create template.
    return template = %{
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
    <h1>Grilla de Turnos</h1>
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
      <% @date.each do |day|%>
      <tr>
      <td id="date"> <%= day %> </td>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "08:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 08" > <%= @name[turno] %></td>
      <% else%>
      <td headers="date 08" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "09:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 09" > <%= @name[turno]%></td>
      <% else%>
      <td headers="date 09" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "10:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 10" > <%= @name[turno] %></td>
      <% else%>
      <td headers="date 10" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "11:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 11" > <%= @name[turno]%></td>
      <% else%>
      <td headers="date 11" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "12:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 12" > <%= @name[turno] %></td>
      <% else%>
      <td headers="date 12" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "13:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 13" > <%=  @name[turno]%></td>
      <% else%>
      <td headers="date 13" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "14:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 14" > <%= @name[turno] %></td>
      <% else%>
      <td headers="date 14" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "15:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 15" > <%= @name[turno] %></td>
      <% else%>
      <td headers="date 15" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "16:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 16" > <%= @name[turno]%></td>
      <% else%>
      <td headers="date 16" > <%= %></td>
      <%end%>
      <% turno= @fulldate.find_index{|t| t.split(" ")[1] == "17:00" && t.split(" ")[0]== day} %>
      <% if (turno!=nil)%>
      <td headers="date 17" > <%= @name[turno] %></td>
      <% else%>
      <td headers="date 17" > <%= %></td>
      <%end%>
      

      </tr>
      <%end%>
      </tbody>
    </table>
  </body>
</html>

  </html>
}.gsub(/^  /, '')
end

def add_feature_all( date, name, surname, phone, professional )
  date = date.delete!".paf"
  index = @fulldate.find_index{|val| val == date}
  if(index!=nil)
    dato = "\n Name: "+name+" Surname: "+surname+" - Phone: "+phone+" Professional: "+professional
    @name[index]=@name[index]+dato
  else
    @fulldate<< date
    @name << "Name: "+name+" Surname: "+surname+" - Phone: "+phone+" Professional: "+professional
    @surname << surname
    @phone << phone
  end
end

def exportprof(week, professional)


  rhtml = ERB.new(get_template)

  # Set up template data.
                   

  lista = Polycon::Models::Appointment.showexportweek(week,professional)
  lista.each do |clave|
    self.add_feature(clave[:date],clave[:name], clave[:surname], clave[:phone], clave[:professional])
  end

# Produce result.
  rhtml.run(self.get_binding)
  File.open(Polycon::PATH+"reporte.html", "w") do |fichero|
    fichero.write(rhtml.result(self.get_binding))
  end
  return "Se generó el reporte solicitado en el directorio #{Polycon::PATH}"
 
  end

  def export(week)


    rhtml = ERB.new(get_template)
  
    # Set up template data.
     lista =[]                
    Dir.foreach(Polycon::PATH) do |prof|
      lista << Polycon::Models::Appointment.showexportweek(week,prof)
    end
    #INTENTO JUNTAR MISMAS FECHAS puts lista.sort{|k,p| k["phone"]==p["phone"]}  
    lista.each do |other|
      other.each do |clave|
      self.add_feature_all(clave[:date],clave[:name], clave[:surname], clave[:phone], clave[:professional])
    end
  end
  
  # Produce result.
    rhtml.run(self.get_binding)
    File.open(Polycon::PATH+"reporte.html", "w") do |fichero|
      fichero.write(rhtml.result(self.get_binding))
    end
    return "Se generó el reporte solicitado en el directorio #{Polycon::PATH}"
   
    end
end