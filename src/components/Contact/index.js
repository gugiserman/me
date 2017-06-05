import React from 'react'
import { getMySocialStuff } from 'utils/'

const links = getMySocialStuff()

const Contact = () => (
  <section className="pa3 pa4-ns lh-copy">
    <h2 className="db ma0 mb3 f5 f4-ns mb1-ns">
      I'm on the internets:
    </h2>
    <ul className="pa0 mt2 list">
      {links.map(({ name, href, icon }, index) => (
        <li className="pv1" key={index}>
          <img src={icon} height="21" className="ph2 v-top" />
          <a className="link blue" href={href} target="_blank">
            {name}
          </a>
        </li>
      ))}
    </ul>
  </section>
)

export default Contact
