interface FilterChipsProps {
  filters: string[];
  activeFilters: string[];
  onFilterToggle: (filter: string) => void;
}

export function FilterChips({ filters, activeFilters, onFilterToggle }: FilterChipsProps) {
  return (
    <div className="flex flex-wrap gap-2">
      {filters.map((filter) => {
        const isActive = activeFilters.includes(filter);
        return (
          <button
            key={filter}
            onClick={() => onFilterToggle(filter)}
            className={`px-4 py-2 rounded-full transition-all ${
              isActive
                ? "bg-[#F0A020] text-white shadow-md"
                : "bg-white text-[#0D1F3A] border border-gray-200 hover:border-[#F0A020]"
            }`}
          >
            {filter}
          </button>
        );
      })}
    </div>
  );
}
