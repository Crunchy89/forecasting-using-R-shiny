#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(DT)

# Define UI for application that draws a histogram
ui <- dashboardPage(
    dashboardHeader(title = "Peramalan"),
    dashboardSidebar(
        sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Metode Peramalan", tabName = "naive", icon = icon("th"))
        )
    ),
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "dashboard",
                            p(HTML("&nbsp;&nbsp;Peramalan adalah suatu proses memprediksi apa yang akan terjadi di masa depan. dalam dunia teknologi peramalan 
                               sering digunakan untuk memprediksi hasil penjualan, pertanian dan lain sebagainya sebagai acuan tindakan apa 
                               yang akan dilakukan kedepannya jika hasil prediksi baik maupun buruk.
                               <br><br>&nbsp;&nbsp;The mean absolute percentage error (MAPE) adalah adalah ukuran paling umum yang digunakan untuk memperkirakan kesalahan, dan berfungsi paling baik jika 
                               tidak ada data yang ekstrem (dan tidak ada angka nol). dari beberapa metode yang ada di aplikasi ini diharapkan 
                               bisa memberikan gambaran metode metode yang dipakai dalam peramalan dan berapa MAPE dari setiap metode. 
                               MAPE tidak 100% sama untuk data yang berbeda, jadi kita harus memilih mana metode yang tepat untuk digunakan dalam 
                               sebuah peramalan. data yang saya gunakan adalah data penumpang pesawat terbang yang telah disediakan oleh R.
                                <br><br>&nbsp;&nbsp;data grafik berwarna biru adalah data asli dari tahun 1950 sampai 1960, Sedangkan data grafik berwarna merah adalah 
                                data hasil prediksi dari tahun 1956 sampai 1960"),align="justify")
            ),
            
            # Second tab content
            tabItem(tabName = "naive",
                    div(class = "container-fluid",
                        box(plotOutput("naive",height = 250),
                        p("Dengan MAPE : ",textOutput('mape_naive')))
                        ,
                        box(plotOutput("dshw",height = 250),
                        p("Dengan MAPE : ",textOutput('mape_dshw')))
                        ,
                        box(plotOutput("bats",height = 250),
                        p("Dengan MAPE : ",textOutput('mape_bats')))
                        ,
                        box(plotOutput("sarima",height = 250),
                        p("Dengan MAPE : ",textOutput('mape_sarima')))
                        
            )
        )
    )
))

