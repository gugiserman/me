import React from 'react'
import { getMySocialStuff } from 'utils/'
import { SectionIcon } from 'commons/'
import earthSVG from 'assets/icons/earth.svg'

const links = getMySocialStuff()

const Contact = () => (
  <section className="pa3 pa4-ns lh-copy">
    <h2 className="db ma0 mb3 f5 f4-ns mb1-ns">
      <SectionIcon icon={earthSVG} description="Globe icon" />
      I'm on the internets
    </h2>
    <ul className="pa0 mt2 list">
      {links.map(({ name, href, icon }, index) => (
        <li className="pv1" key={index}>
          <a className="link blue" href={href} target="_blank">
            <img src={icon} className="h1 ph2 v-base" alt={`${name} icon`} />
            {name}
          </a>
        </li>
      ))}
    </ul>
  </section>
)

export default Contact
