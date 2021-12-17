document.addEventListener('DOMContentLoaded', () => {
  const askButton = document.getElementById('ask-button')
  askButton.addEventListener('click', formHider)
})

const formHider = (event) => {
  event.preventDefault()
  const askForm = document.getElementById('ask-form')

  setTimeout(() => {
    askForm.classList.toggle('hide')
  }, 300)
}
