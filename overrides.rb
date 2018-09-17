# Write in this file customization code that will get executed after all the
# soures have beenloaded.

# if Autoproj::Metapackage.method_defined?(:weak_dependencies?)
#     metapackage('rock').weak_dependencies = true
#     metapackage('rock.toolchain').weak_dependencies = true
#     metapackage('rock.base').weak_dependencies = true
# end

# Autoproj.manifest.each_autobuild_package do |pkg|
#     next if !pkg.kind_of?(Autobuild::Orogen)
#     pkg.orogen_options << '--extensions=metadata_support'
#     pkg.depends_on 'tools/orogen_metadata'
# end

Autobuild::Package.each do |name, pkg|
    next if !pkg.kind_of?(Autobuild::CMake)

    if !pkg.defines.has_key?('CMAKE_BUILD_TYPE')
        if(pkg.tags.empty?)
           pkg.define "CMAKE_BUILD_TYPE", "RelWithDebInfo"
        end
    else
        if(pkg.defines["CMAKE_BUILD_TYPE"] == 'Debug' && pkg.tags.empty?)
           pkg.define "CMAKE_BUILD_TYPE", "RelWithDebInfo"
        end
    end

    pkg.define "ROCK_USE_CXX11", "TRUE"
    pkg.define "CMAKE_CXX_FLAGS", "-std=c++11"
end
