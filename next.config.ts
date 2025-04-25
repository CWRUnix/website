import type { NextConfig } from "next";
// ./src/env.ts
import { env } from "src/env.js";
// See https://github.com/gregrickaby/nextjs-github-pages
const nextConfig: NextConfig = {
	typescript: {
		ignoreBuildErrors: true,
	},
	eslint: {
		ignoreDuringBuilds: true,
	},
	/**
	 * Enable static exports.
	 *
	 * @see https://nextjs.org/docs/app/building-your-application/deploying/static-exports
	 */
	output: "export",

	/**
	 * Set base path. This is the slug of your GitHub repository.
	 *
	 * @see https://nextjs.org/docs/app/api-reference/next-config-js/basePath
	 */
	//basePath: "/nextjs-github-pages",

	/**
	 * Disable server-based image optimization. Next.js does not support
	 * dynamic features with static exports.
	 *
	 * @see https://nextjs.org/docs/app/api-reference/components/image#unoptimized
	 */
	images: {
		unoptimized: true,
	},
};

export default nextConfig;
