document.getElementById('jam_photo').addEventListener('input', function(event) {
  const output = document.getElementById('photo_output');
  output.src = URL.createObjectURL(event.target.files[0]);
});
