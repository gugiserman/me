import React from 'react'
import { SectionIcon } from 'commons/'
import briefcaseSVG from 'assets/icons/briefcase.svg'

const CurrentWork = () => (
  <section className="pa3 pa4-ns lh-copy">
    <h2 className="mb0 f5 f4-ns">
    <SectionIcon icon={briefcaseSVG} description="Briefcase icon" />
      <span>I work at</span>&nbsp;
      <a className="link blue" target="_blank" href="http://engineering.vtex.com">
        VTEX
      </a>
    </h2>
    <p>
      We’re redefining commerce.
      <br />
      You should take a look.
    </p>
  </section>
)

export default CurrentWork
