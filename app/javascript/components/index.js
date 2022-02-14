import React from 'react'
import ReactDOM from 'react-dom'

const Index = props => (
  React.createElement('div', null, `Index ${props.name}`)
)

Index.defaultProps = {
  name: 'David'
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    React.createElement(Index, {name: 'Rails 7'}, null),
    document.getElementById('app'),
  )
})