import { BadgeCheck, Leaf, Sprout, PackageCheck } from "lucide-react";

const certs = [
  { name: "FSSAI Licensed", icon: BadgeCheck },
  { name: "No Preservatives", icon: Leaf },
  { name: "Farm Fresh", icon: Sprout },
  { name: "Hygienically Packed", icon: PackageCheck },
];

export default function Certifications() {
  return (
    <section className="section container">
      <h2 className="title">Why Choose Us</h2>
      <div className="certs">
        {certs.map(({ name, icon: Icon }) => (
          <div className="cert" key={name}>
            <div className="cert-circle">
              <Icon size={34} strokeWidth={1.6} />
            </div>
            <p>{name}</p>
          </div>
        ))}
      </div>
    </section>
  );
}