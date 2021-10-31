# PG5601examn


## Swift 5 & XCode 13.0

### Bruker Oversikt
Her ligger alle de nødvendige feltene.
Dersom en bruker har bursdag eller har hatt bursdag innen de neste/forrige 7 dagene vil det regne gratulasjons emojier og komme en emoji nederst til høyre i profilbildet til brukeren. Siden det ikke stod spesifisert i oppgaven har jeg ikke lagt til emojien i profilbilde i TableView'en på forsida.
Det er også mulig å vise den ene brukeren i kartet eller sletter brukeren. Blir brukeren slettet vil ID'en til brukeren bli lagt til i UserDefaults og forhindret og bli lagt til dersom et nytt API-kall skjer.

### Rediger Bruker
På denne siden er det mulig å redigere brukeren. Dersom du trykker på 'Back' vil ingenting endringer bli lagret. Her har jeg også lagt inn mulighet til å trykke på retur på tastaturet for å gå til neste felt. Om brukeren endrer på alderfeltet vil fødselsdato også automatisk bli oppdatert. Det samme gjelder motsatt vei.
På fødselsdato har jeg brukt Native DatePicker til å endre feltet.
Når brukeren utfører en endring på en bruker, tikkes attributten isEdited og vil bli lastet inn ved alle nye fetch-requester til brukeren blir slettet. Dataen i de andre skjermene vil også bli oppdatert ved utført endring/oppdatering en Bruker.

### Kartet
Kartet viser alle 100 personene med bilde og navn. Her er det mulig å trykke på en pin og komme til Bruker Oversikten til den valgte brukeren. Samme ViewController brukes også for å vise en bruker.
I denne delen av oppgaven fikk jeg dessverre ikke til å kun vise profilbilde og navn, men måtte se meg slått av den urørlige pin'en.

### Innstillinger
Her kan brukeren endre seed og som vil importere 100 nye brukere fra API-et. Dersom en bruker er slettet fra kallet tidligere vil den ikke dukke opp igjen når du laster inn seed-en. Om du har endret en bruker fra en annen seed vil den forbli i lista og i tillegg til de nye brukerne.

## CoreData og UserDefaults
I oppgaven bruker jeg både CoreData og UserDefaults. Første gang brukeren åpner applikasjonen vil data fra API-et lastes inn i CoreData. På denne måten trenger brukeren kun internett første gang han åpner appen, og eventuelt hvis han vil laste inn ny seed.
UserDefaults har jeg brukt til mindre komplekse verdier, som for å sjekke om det er første gang brukeren bruker appen og ID til slettede brukere.

## Error-Handling
Dersom brukeren forsøker å gjøre et API-kall uten å ha tilgang til internett vil det bli gitt en Alert til brukeren med et alternativ til å prøve å laste dataen på ny.


### Used for loading images
https://www.hackingwithswift.com/example-code/uikit/how-to-load-a-remote-image-url-into-uiimageview 


### Date Picker
https://www.youtube.com/watch?v=fnq4wEDeQqA
