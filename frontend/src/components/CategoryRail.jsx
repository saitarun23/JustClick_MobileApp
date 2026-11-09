import React from 'react';
import { CATEGORIES } from '../data/mockData';

export default function CategoryRail({ activeCategory, setActiveCategory }) {
  return (
    <aside className="w-full md:w-64 shrink-0">
      <div className="bg-white rounded-2xl p-4 border border-slate-200/80 shadow-sm sticky top-24">
        <h3 className="text-xs font-bold uppercase tracking-wider text-slate-400 mb-3 px-2">
          Categories
        </h3>
        
        <div className="flex md:flex-col gap-1.5 overflow-x-auto pb-2 md:pb-0 scrollbar-none">
          {CATEGORIES.map((cat) => {
            const isActive = activeCategory === cat.id;
            return (
              <button
                key={cat.id}
                onClick={() => setActiveCategory(cat.id)}
                className={`flex items-center justify-between p-2.5 rounded-xl transition-all whitespace-nowrap md:whitespace-normal ${
                  isActive 
                    ? 'bg-emerald-600 text-white font-bold shadow-md shadow-emerald-600/20' 
                    : 'text-slate-700 hover:bg-slate-100/80'
                }`}
              >
                <div className="flex items-center gap-3">
                  <img 
                    src={cat.image} 
                    alt={cat.name} 
                    className="w-7 h-7 rounded-lg object-cover"
                  />
                  <span className="text-sm font-medium">{cat.name}</span>
                </div>
                <span className={`text-xs px-2 py-0.5 rounded-full ${
                  isActive ? 'bg-white/20 text-white' : 'bg-slate-100 text-slate-500'
                }`}>
                  {cat.count}
                </span>
              </button>
            );
          })}
        </div>
      </div>
    </aside>
  );
}