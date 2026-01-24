window.onload = function() {
   var data;
   var promiseFetch = fetch('/fonoteca/albums.json');
   
   promiseFetch.then(function(response){
       if(response.status == '200')
         console.log(response.json());
       else
         throw "eroare";})
       .catch(function(err){
         alert(err);});
   
}

