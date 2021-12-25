document.addEventListener('turbolinks:load', () => {
  let header_color = document.getElementById('header_color')
  if (header_color) {
    let preview_header_color = document.getElementById('preview_header_color')

    const header_colorAssign = () => { preview_header_color.style.background = header_color.value }

    header_colorAssign()

    document.getElementById('header_color').onchange =  () => { header_colorAssign() }
  }
})
