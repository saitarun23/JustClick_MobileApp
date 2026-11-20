import { Smartphone, PackageCheck, Truck, Star } from 'lucide-react'

const steps = [
  { icon: Smartphone, title: 'Place your order', text: 'Pick fresh products from the app or website in a few taps.' },
  { icon: PackageCheck, title: 'Packed at the farm', text: 'Farmers pack your order the same day, right at the source.' },
  { icon: Truck, title: 'Delivered to your city', text: 'Our trucks and riders bring it to your doorstep, fast.' },
  { icon: Star, title: 'Enjoy and review', text: 'Taste the difference and rate your experience.' },
]

export default function HowItWorks() {
  return (
    <section id="how" className="section section--green">
      <div className="container">
        <h2 className="section__title">How farm2bay works</h2>
        <div className="steps">
          {steps.map((s, i) => (
            <div className="step" key={s.title}>
              <span className="step__num">{i + 1}</span>
              <span className="step__icon"><s.icon size={30} strokeWidth={1.8} /></span>
              <h3>{s.title}</h3>
              <p>{s.text}</p>
            </div>
          ))}
        </div>

        <div className="road-strip" aria-hidden="true">
          <Truck className="road-strip__truck" size={44} strokeWidth={1.8} />
        </div>
      </div>
    </section>
  )
}