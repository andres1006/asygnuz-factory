import type { NextConfig } from "next";
import path from "path";

const nextConfig: NextConfig = {
  // Raíz del monorepo (template/): evita advertencia de lockfile al usar pnpm workspace
  turbopack: {
    root: path.join(__dirname, "../.."),
  },
};

export default nextConfig;
